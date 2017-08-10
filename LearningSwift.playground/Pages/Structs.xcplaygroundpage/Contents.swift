// If a method changes a property of a struct, it has to be marked mutating
// Structs are pased by value and are copy on write, so if swift needs to
// know when to copy it, it needs to know when you change it.
struct Point {
    var x = 0
    var y = 0
    
    mutating func changeLocation(moveXBy: Int, moveYBy: Int) {
        x += moveXBy
        y += moveYBy
    }
    
}

/* Classes vs structs
 Classes and structures in Swift have many things in common. Both can:
 
 Define properties to store values
 Define methods to provide functionality
 Define subscripts to provide access to their values using subscript syntax
 Define initializers to set up their initial state
 Be extended to expand their functionality beyond a default implementation
 Conform to protocols to provide standard functionality of a certain kind
 For more information, see Properties, Methods, Subscripts, Initialization, Extensions, and Protocols.
 
 Classes have additional capabilities that structures do not:
 
 Inheritance enables one class to inherit the characteristics of another.
 Type casting enables you to check and interpret the type of a class instance at runtime.
 Deinitializers enable an instance of a class to free up any resources it has assigned.
 Reference counting allows more than one reference to a class instance.
 
 Structers are always passed around when copied, classed passed by reference!!!!
 */


// More struct examples, if a stuct properties have default values, initializing with
// () is possible:
struct Rectangle {
    var height: Int
    var width: Int
}
var rectangle = Rectangle(height: 10, width: 12)

struct Rectangle2 {
    var height = 10
    var width = 12
}
var rectangle2 = Rectangle2()
// Stucts can have competed properties, which are caculatedo on the fly when you need
// them, and can depend on other properties
struct Rectangle3 {
    var height: Int
    var width: Int
    var area: Int {
        return width * height
    }
}
var rectangle3 = Rectangle3(height: 3, width: 5)
print("The area of this rectangle is \(rectangle3.area)")

// You can also have generic structs which elements whose type is specified later
// Usefull for tableview
struct NamedArray<Element> {
    var name: String
    var items: [Element]
}
// You don't have to write the type of Element if you don't want.
let boardGames = NamedArray<String>(name: "Board Games", items: ["Backgammon, Chess"])
let primes = NamedArray(name: "Prime Numbers", items: [2, 3, 5, 7, 11])



// Structures can also have property getters, setters and observers just like classes.
// You define them inside the variable {} block.
// willSet is a special method run before a property is set to a new value and 
// didSet is run after a property has been set to a new value.
// In willSet, swift uses newValue to refer to the new value
// in didSet,  swift uses oldValue to refer to the old value.



struct Person {
    var age: Int
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        didSet {
            updateUI(msg: "I've changed from \(oldValue) to \(clothes)")
        }
    }
    var ageInDogYears: Int {
        get {
            return age * 7
        }
        set {
            print("Calculating dog year...")  // will only run when value is changed.
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var vmachiel = Person(age: 29, clothes: "Suit")
vmachiel.clothes = "T-Shirt"
vmachiel.ageInDogYears






/* Structure instances are always passed by value, and class instances are always passed by
 reference. This means that they are suited to different kinds of tasks. 
 As you consider the data constructs and functionality that you need for a project,
 decide whether each data construct should be defined as a class or as a structure.
 
 As a general guideline, consider creating a structure when one or more of these conditions apply:
 
 - The structure’s primary purpose is to encapsulate a few relatively simple data values.
 - It is reasonable to expect that the encapsulated values will be copied rather than
 referenced when you assign or pass around an instance of that structure.
 - Any properties stored by the structure are themselves value types, which would also be
 expected to be copied rather than referenced.
 - The structure does not need to inherit properties or behavior from another existing
 type.
 
 Examples of good candidates for structures include:
 - The size of a geometric shape, perhaps encapsulating a width property and a height
 property, both of type Double.
 - A way to refer to ranges within a series, perhaps encapsulating a start property and
 a length property, both of type Int.
 - A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each
 of type Double.
 - In all other cases, define a class, and create instances of that class to be managed
 and passed by reference. In practice, this means that most custom data constructs
 should be classes, not structures.
 */











