// init is a special method to initialize every property that wasn't inited
// by lazy, = value, being an optional, executing a closure. 
// There can be multiple inits: think of String. It has an init that takes a double,
// an init that takes another String and so on.


// Callers use inits by using your type's name and arguments if needed
let testNumber = String(45.2)
let emptyString = String()
// or var brain = CalculatorBrain()


// Some get init() for free:
// Base classes that don't inherit from anything get free init with no arguments

// Structs get a default init with all properties as the arguments
// So you don't write an init:
struct PendingBinaryOperation {
    var function: (Double, Double) -> Double
    var firstOperand: Double
}
// This gets a free init(function: (Double, Double) -> Double, firstOperand: Double {
// }
// Which is used by simply:
let pbo = PendingBinaryOperation(function: +, firstOperand: 3)
// The free one is GONE if you init one yourself: then you write them for everything!

// What to do in an init():
// Set property's value, even if it has a default.
// Set constant properties (let): Init can override a let default!
// Call other inits by things like self.init(args) or super.init()

// CLASS ONLY:
// You are required to init all of your vars by the time init is done.
// Two init types: convenience and not-convenience (designated, or REGULAR)
// Regular are the main one, convenience are secondary or "helper"
// A designated init can only call a designated init in it's immediate superclass
// You must init all properties introducted by your class before calling super.init
// You must call a super.init before you assign values to inherited properties.
// Convenience inits can only cal regular init in its own class
// Convenience init must call that init before setting properties on its own
// All init's must be done before calling methods or access properties.
// INHERIT INITS
// if you don't implement regular inits, you'll inherit superclass regulars. 
// If you override all of your superclass regular init, you'll inherit the conve
// nience inits. 
// If you don't implement any inits, you inherit everything.

// Required inits
// you can mark your class init as required: any subclass must implement them (or inherit
// them). 
// Failable init
// init?() may fail and are used with optionals. Example is Double(string value here), has
// one, incase the string can't be converted. The init will set the instance to nil.














