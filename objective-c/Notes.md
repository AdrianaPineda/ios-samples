# Creating objects

We use alloc and init, but we also use class methods. Sometimes both a class creator method and init method exist

Class methods were used before ARC to be clear how to reference and de-reference objects. Class methods would create the object so it could be released in a certain way

Looks like Apple is moving towards alloc/init

Other ways of creating objects:

* Other objects create new objects 
  * NSString `stringByAppendingString`
  * NSArray `componentsJoinedByString`
  * NSString & NSArray `mutableCopy`

Unless a method has the word `copy` in it, we get a pointer. For example: NSArray `lastObject`

# nil

Sending messages to `nil` does not make the app crash, code is not executed thats all

`int i = [obj methodWhichReturnsNil]` will return *zero* if obj is nil

Careful if the method returns a C struct, we do need to check if its nil: 

`CGPoint p = [obj getLocation]` will return *undefined* if obj is nil

# Dynamic Binding

Objective-C has an important type called `id` => *pointer* to an object of unknow/unspecified type

`id myObject`

All pointers in Objective-C are `id`s

If we use `id` instead of a specific type (i.e `NSString`) the code to execute when a message is sent is figured out at runtime. This is called dynamic binding

Is this safe? 
* If we send a message to an object and it doesn't understand it? Crash

However, we should use specific types, hence use `static binding`

```objc
NSString *s = @"x"; // statically typed

id obj = s; // not statically typed, but compiler can't catch `[obj rank]`

NSArray *a = obj; // Legal, but will lead to trouble
```

⚠️ never use `id *`, `id` is a pointer, that would mean a pointer to a pointer to an object -> ❌

```objc
NSString *hello = @"hello";
NSArray *test = (NSArray *)hello; // no error
[test firstObject]; // crash
```

To make dynamic typing safer, we should use Introspection and Protocols

`Introspection`: asking at runtime what class an object is or what messages can be sent to it

`Protocols`: a syntax that is 'in between' `id` and `static typing`. Does not specify the class of an object pointed to, but does specify what methods it implements


## Introspection (@ runtime)
We use it for example for:
* Getting objects out of array (since arrays don't specify the type)
* MVC communication (target, action, delegation, etc)

`isKindOfClass` // inheritance included

`isMemberOfClass`// no inheritance

`respondsToSelector` // checks if object has a method with that signature


`SEL` is the objective-c type for a selector:
```objc
SEL shootSelector = @selector(shoot);
```

If we have a `SEL` we can ask an object to perform it:

```objc
// Single object
[objc performSelector: shootSelector];
[objc performSelector: shootSelectorArgs withObject:param];

// Ask array perform selector for all elements
[array makeObjectsPerformSelector: shootSelector];

// UIButton
[button addTarget: self action:@selector(pressed:) ...];
```

# Foundation Framework

## NSObject
Base class for pretty much every object in the iOS SDK

Implements instrospection

Implements `description`

```objc
NSLog(@"array contents are %@", myArray);
// The `%@` is replaced with the results of invoking `[myArray] description`
```

### Copying objects:
Methods `copy` (immutable copy) and `mutableCopy` vary from class to class, because they are up to the class to implement.

Not all objects implement these methods

NSObject **does not** implement these methods

## NSArray
Ordered collection of objects

Immutable

All objects in the array are held onto strongly in the heap. As long as the array is in the heap (someone has a strong pointer to the array itself) all the objects that are in the array will stay in the heap as well, because there will be strong pointers to all of them

### NSMutableArray
Mutable version of `NSArray`

Inherits all of `NSArray`'s methods

Create with:
* `alloc`/`init`
* `+ (id)arrayWithCapacity:(NSUInteger)numItems;` numItems is a *performance hint* only, the array is not initialized with that amount of items
* `+ (id)array` => `[NSMutableArray array]` == `[[NSMutableArray alloc] init]`

## Eumeration
Looping through members of an array in an efficiente manner `for-in`

```objc
NSArray *myArray = ...;
// this is casting:
for (NSString *string in myArray) { // no way for compiler to know what `myArray` contains
  double value = [string doubleValue]; // ⚠️ crash if `string` is not `NSString`
}

// alt
for (id obj in myArray) {
  if ([obj isKindOfClass...])
}

```

## NSNumber
Object wrapper around primitive types like `int`, `float`, `double`, `BOOL`, `enum`s, etc

```objc
NSNumber *n = [NSNumber numberWithInt: 36];
float f = [n floatValue];
NSNumber *three = @3;
```

## NSValue
Generic object wrapper for some non-object, non-primitive data types (i.e C structs)

```objc
NSValue *edgeInsetsObject = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
```
A good way to wrap up a struct is to turn it into a string

## NSData
"Bag of bits". Used to save/restore/transmit raw data throughout the iOS SDK
## NSDate
Used to find out the time right now or to store past or future dates/time
Careful with localization of dates

## NSSet / NSMutableSet
Like an array, but no ordering (no `objectAtIndex:` method)

## NSOrderedSet / NSMutableOrderedSet
A cross between `NSArray` and `NSSet`

## NSDictionary
Immutable collection of objects looked up by a key (has table)
All keys and values are hel onto `strong`ly by an NSDictionary

```objc
NSDictionary *colors = @{@"green": [UIColor greenColor], @"blue": [UIColor blueColor]};

// To lookup
// `key` *must* implement `hash` and `isEqual:` properly
UIColor *colorObject = colors[@"xyz"];
UIColor *colorObject = [colors objectForKey:@"xyz"];
```

⚠️ Careful with `NSObject`'s `hash` and `isEqual:`
* `hash` is the pointer
* `isEqual:` is `==`

If you use a NSObject as a key, it will probably do pointer hashing and it will fail: no two objects will be the same because no two objects have the same pointer

`NSString` are excellent keys

## NSMutableDictionary
Mutable version of `NSDictionary`

Create using `alloc`/`init` or one of the `+ (id) dictionary...` class methods

Looping through the keys or values:
```objc
NSDictionary *myDic = ...;
for (id key in myDic) {
  id value = [myDict objectForKey: key];
}
```

## Property list
Collection of collections

Any graph of objects containing `NSArray, NSDictionary, NSNumber, NSString, NSDate, NSData` (or mutable subclasses).

An `NSArray` is a Property List if all its members are too

An `NSDictionary` is one only if all keys and values are too

## NSUserDefaults
Lightweight storage of Property Lists

Not a full-on database, so only store small things like user preferences

Always remember to call `synchronize` to make the changes permanent

## NSRange
C struct (not a class)

⚠️ We **don't** put structs in the heap

A possible location can be `NSNotFound`: value of `location` in a range that was not found
```objc
NSString *greeting = @"hello word";
NSString *hi = @"hi";
NSRange r = [greeting rangeOfString:hi];
if (r.location == NSNotFound) { /* couldn't find `hi` inside `greeting`*/}
```

`NSRangePointer`: `NSRange *...`

^ is for call by reference range (so it can be modified)

# UIKit

## UIColor
An object representing a color

Alpha: (how opaque a color is)
* 1: fully opaque
* 0: fully transparent

## UIFont
We need to get fonts right

```objc
UIFont *font = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];

/** Other styles:
UIFontTextStyleHeadline
UIFontTextStyleCaption1
UIFontTextStyleFootnote
...
*/
```

There are also `system` fonts that are used in places like button titles. However, you should **never** use it for your user's content, we should use `preferredFontForTextStyle`

## UIFontDescriptor
A `UIFontDescriptor` attempts to categorize a font anyway. It does so by family, face, size, and other attributes. You can then ask for fonts that have those attributes and get a "best match"

## Attributed String - NSAttributedString
How text looks on screen

Is 'like' an NSString where each character has an NSDictionary of "attributes". The attributes are things like the font, the color, underlining, etc of the character

Its **not** a subclass of `NSString`, but it **does** provide a method `string`

```objc
- NSString *string;
```

The method `string` is guaranteed to be very high performance but its volatile. If you want to keep it aroundm, make a `copy` of it.

## NSMutableAttributedString
Mutable version of `NSAttributedString`

If we want to modify the characters in an NSMutableAttributedString
```objc
- NSMutableString *mutableString;
```

If we modify the `mutableString` ^, the `NSMutableAttributedString` (its attributes) will track the changes

### What kind of attributes are there
* NSFontAttributeName
* NSForegroundColorAttributeName
* NSStrokeWidthAttributeName: negative number means "fill and stroke", positive numbers is "stroke" only (outline)
* NSStrokeColorAttributeName
* NSUnderlineStyleAttributeName
* NSBackgroundColorAttributeName

### Where do attributed strings get used?
* UIButton `-(void)setAttributedTitle(NSAttributedString *)tile forState:...;`
* UILabel `NSAttributedString *attributedText;`
* UITextView `NSTextStorage *textStorage;`

### Drawing string directly
We can also draw string directly. `NSAttributedString`s know how to draw themselves on screen

```objc
- (void)drawInRect: (CGRect)aRect;
```

## UILabel
`attributedText` is immutable

So to modify a `UILabel`, you need to make a `mutableCopy`, modify it and set it back
```objc
NSMutableAttributedString *labelText = [myLabel.attributedText mutableCopy];
[labelText setAttributes:...];
myLabel.attributedText = labelText;
```

## UITextView

Scrollable, editable/selectable view of a mutable attributed string

Similar to UILable, but multi-line.

We can set a NSMutableAttributedString & NSFont

## View Controller lifecycle
Sequence of messages (series of methods) sent to UIViewController when things happen

Why does this matter?
* to override them when needed

### How is it?
**Start of the lifecycle**
- Creation: most VC's are created out of the storyboard

**What then?**
- outlet setting
- appearing and disappearing
- geometry changes (device rotation for example)
- low-memory situations

at each stage, iOS invokes method(s) on the Controller

⚠️ always let `super` have a chance in lifecycle methods

### viewDidLoad
- Outlets have been set
- A good  place to put a lot of setup code
- Only called once
- Bounds (geometry) of the view **not** finalized at this point, so ⚠️ dont ⚠️ initialize things that are geometry-dependent here

### viewWillAppear
- Call just before the view appears on screen
- Can be called multiple times
- View will only get "loaded" once, but it might appear and disappear a lot
- Do something here if things you display are changing while your MVC is off-screen
- We can do stuff here to optimize performance (i.e doing a network call in viewDidLoad might not be needed if the view never appears and we wasted resources on it)
- The view's geometry is set here so we *could* set some initialization based on geometry here, but there is a better place to do geometry-based initialization. However, geometry *can* change after viewWillAppear (for example when view rotates we wont get viewWillAppear called)

### viewWillDisappear
- Where we put "remember what's going on" and cleanup code
- Stop using resources
- Don't do anything time-consuming here or app will be sluggish, maybe kick off a thread to do what needs doing here

### view{Will,Did}LayoutSubviews
- Called any time a view's frame changed and its subviews were thus re-layed out (i.e. autorotation)
- We can rese the frames of the subviews here or st other geomety-affecting properties
- Between "will" and "did", autolayout will happen

### Autorotation
- Happens only if:
  - `shouldAutorotate` returns `YES`
  - `supportedInterfaceOrientations` returns the new orientation
  - The application allows rotation to that orientation (defined in Info.plist file)

### didReceiveMemoryWarning
- In low-memory situations this method is called.
- Rarely happens
- Images, video and/or sounds use a lot of memory. Small dictionaries dont use a lot of memory
- If it is called, we might need to release anything "big" that can be recreated (i.e an alternate image or something thats not on screen)

### awakeFromNib
- Happens before outlets are set
- Put things here that can't wait until `viewDidLoad`
- This method is sent to all objects that come out of a storyboard
- UIViewController's designated initializer is `initWithNibName:bundle:`

### Summary
1. Instantiated (from storyboard)
1. awakeFromNib
1. outlets get set
1. viewDidLoad
1. [when geometry is determined] viewWillLayoutSubviews & viewDidLayoutSubviews
1. [can happen repeatedly as the VC appears and disappears from the screen] 
    1. viewWillAppear and viewDidAppear
    1. [when geometry changes again while visible i.e rotation] viewWillLayoutSubviews & viewDidLayoutSubviews
    1. viewWillDisappear and viewDidDisappear
1. [if memory gets low] didReceiveMemoryWarning

## NSNotification
The "radio station"

### NSNotificationCenter
Default notification center. 

Access it via `[NSNotificationCenter defaultCenter]`

If we want to "listen to a radio station" call `addObserver:selector:name:object:`
- observer: the object to get notified
- selector: method to invoke if something happens
- name: name of the sation (a constant)
- sender: whose changes you are interested in (nil is anyone's)