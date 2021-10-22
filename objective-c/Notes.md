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