// Also in Classes and Objects
// First, structs and enums are value type and classes are reference type.
// The previous sentence is horrendous. It doesn’t make sense for beginners. 
// Okay let me explain. In Classes, when you make a
// copy of a reference type variable, both variables are referring to the same object 
// in memory. A change to one of the variables will change the other. In Structs, 
// however, you simply copy and paste variables by creating a separate object. 
// Again, think of the analogy I used: textbook answer keys (Class) vs whole new 
// textbooks (Struct)

struct SomeStruct {
    var property = "original"
}

class SomeClass {
    var property = "original"
}

// Create instances of both
var valueType = SomeStruct()
var referenceType = SomeClass()

// Make a copy of both that you don't need to change
let valueTypeCopy = valueType
let referenceTypeCopy = referenceType

// Change the original properties:
valueType.property = "new"
referenceType.property = "new"

// And now the copies are:
valueTypeCopy.property
referenceTypeCopy.property

// The original struct didn't change, because you it's a value type: when you made the
// copy, a whole new object was created. A class is a referrence type: when you made the
// the copy, you really just made a second way to refer to the existing object. When you
// changed the orginial object, the second refference "sees" the change as well and thus
// changes from your perspective. 


// Enums are like structs: valuetypes:
enum SomeEnum: Int {
    case property = 1
    case property2
}

var valueType2 = SomeEnum(rawValue: 1)
let valueType2Copy = valueType2

valueType2 = SomeEnum(rawValue: 2)
valueType2Copy


// Extra from the CS193P course.

// value types assigned to constants are IMMUTABLE. In the viewcontroller of calc,
// we assigned the calc brain (struct) to a var. Everytime a mutable function is called,
// it's changed by copying! Copy on write. If it were a let, you couldn't call 
// any mutable functions. 

// Reference types are stored in the heap, and only a pointer is assigned to a 
// var or constant.
// If you assign a reference type to a constant let x = Someclass, you can still
// change properties and called methods that do that. The stuff in the heap gets
// changes, the pointer to it stays the same, which is stored in the constant.

// Using structs as much a possible is like functional programming. With classes,
// you can have multiple locations pointing to one object, all of whom can change that
// object (side effects). When you use structs, if another var or constant is set to
// that data, it copies it. So when one of them calls a method, it's like func. 
// programming: data goes in, predictable data comes out.
// This is new to macOS and iOS, which were designed with ref. types only in mind
// Swift has powerful structs, protocols and generics, making proper func. programming
// possible.

// Always keep immutability in mind when designing with swift. If you can do!, it's way
// easier to test math function instead of mutable classes with many pointers to them
// and having to set up a lot of stuff. 
















