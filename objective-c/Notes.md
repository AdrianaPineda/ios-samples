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