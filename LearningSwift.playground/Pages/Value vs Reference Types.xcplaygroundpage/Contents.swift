// Also in Classes and Objects
// First, structs and enums are value type and classes are reference type.The previous sentence is
//horrendous. It doesn’t make sense for beginners. Okay let me explain. In Classes, when you make a
//copy of a reference type variable, both variables are referring to the same object in memory. A
//change to one of the variables will change the other. In Structs, however, you simply copy and
//paste variables by creating a separate object. Again, think of the analogy I used: textbook answer
//keys (Class) vs whole new textbooks (Struct)

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










