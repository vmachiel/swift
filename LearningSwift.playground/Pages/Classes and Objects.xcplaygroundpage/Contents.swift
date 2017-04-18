// Basic class definition
class Shape {
    // add constants and vars
    var numberOfSides = 0
    let dimensions = 2
    // Methods can take arguments but don't have to.
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) Sides and \(dimensions) dimensions"
    }
    func addSides(number: Int) {
        numberOfSides += number
    }
}
var shape = Shape()
shape.numberOfSides = 5
shape.simpleDescription()
shape.addSides(number: 4)
shape.simpleDescription()

// Define initializers with the 'init' keyword: what to do when a instance is made
// deinit can define some cleanup before an object is deallocated.
class NamedShape {
    var numberOfSides: Int = 0 // defined at declaration.
    var name: String // to be defined at initialization
    
    init(name: String) {
        self.name = name
    }
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) Sides"
    }
}

// You subclass be adding the superclass name like the following. 
// Overriding methods is done with 'override'
// self is not necessary except for init. You can call instance.sidelenght the same as
// instance.name or numberOfSides  Use it at extensions en disambiuity.

class Square: NamedShape {
    var sideLength: Double  // to be definied at init
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)  // pass the name to the init methods of NamedShape
        numberOfSides = 4
    }
    func area() -> Double{
        return sideLength * sideLength
    }
    override func simpleDescription() -> String {  // override the inherited method
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()
test.sideLength = 5.3  // access and change variables.
test.area()
// So far, pretty similar to python. 

// Getters and setters can also be used (encapsulation etc)
// If no new name is given in the set function: newValue is used
class EquilateralTriangle: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0  // newValue is default
        }
    }
    override func simpleDescription() -> String {  // override the inherited method
        return "An equ triangle with sides of length \(sideLength)."
    }
    
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)  // = 3.0 * sidelength
triangle.perimeter = 9.9  // divide by 3.0 gives:
print(triangle.sideLength)

// Property observers are called everytime the property is set, even if the same value
// willSet is called before, and didSet is called after
class TriangleAndSquare {
    var triangle:EquilateralTriangle {  // remember, variables can be self made objects
        // the following is run when the var triangle is set (first, new or same value)
        willSet {
            square.sideLength = newValue.sideLength  // Reversed of below
        }
    }
    var square: Square {
        // When square is set to a new, same of first value:
        willSet {
            triangle.sideLength = newValue.sideLength  // New value = Square(sideLenght: 50, 
            // name: "larger square"
            // so the triangle.sideLength is set to the same value as the new square.sideLength
        }
    }
    // So square and triangle are instances of Square and Equiblabla
    // When they are initialized, they are both passed a size and a name but before they are
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)  // So if one gets set, the willSet method takes that 
// new value and sets it to the other, so they're te same!!!!

// Another example to better show explicitly stating names newVal instead of newValue
class family {
    var _members:Int = 2
    var members:Int {
        get {
            return _members
        }
        set (newVal) {
            if newVal >= 2 {
                _members = newVal
            } else {
                print("error: cannot have family with less than 2 members")
            }
        }
    }
}

// optional values work ond self defined classes as well:
let optionalSquare: Square? = Square(sideLength: 4.4, name: "optional square")
let sidelength = optionalSquare?.sideLength // does it exist? than assign.


// Classes vs structs
// Classes and structures in Swift have many things in common. Both can:
//
// Define properties to store values
// Define methods to provide functionality
// Define subscripts to provide access to their values using subscript syntax
// Define initializers to set up their initial state
// Be extended to expand their functionality beyond a default implementation
// Conform to protocols to provide standard functionality of a certain kind
// For more information, see Properties, Methods, Subscripts, Initialization, Extensions, and Protocols.
//
// Classes have additional capabilities that structures do not:
//
// Inheritance enables one class to inherit the characteristics of another.
// Type casting enables you to check and interpret the type of a class instance at runtime.
// Deinitializers enable an instance of a class to free up any resources it has assigned.
// Reference counting allows more than one reference to a class instance.












