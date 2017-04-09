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






















