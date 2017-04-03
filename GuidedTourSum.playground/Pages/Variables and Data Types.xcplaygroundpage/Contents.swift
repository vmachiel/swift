// Hello world is easy, complete with autonewline!

print("Hello World")

/* Variables are declared once with "var" and constants with "let
 When you assign a new value to a variable it needs to be of the same type */

var myVariable = 42
myVariable = 51
print(myVariable)
let myConstant = 51.2

/* Compiler can infer the type at initialization. You can also 
 explicitely define it. You must also define conversion to another
 type if needed! */

let implicitDouble = 23.4
let explicitDouble: Double = 22
let explicitFloat: Float = 53

let label = "The width is "
let width = 94
let widthLabel = label + String(width)

// You can simply do it with backslash as well (kinda like f-strings in python)

let apples = 3
let oranges = 5
print("I have \(apples) apples, and I have \(apples + oranges) pieces of fruit")
print("Hello there: \(implicitDouble) + \(Double(explicitFloat))") // Look at this!!


/*Arrays and Dicts are declared with [] any are both ordered.
  Acces them with indecis, and a comma is allowed at the end. 
  Again, types are inferred */

var shoppingList = ["Bananas", "Yogurt", "More stuff",]
var ammountOfCash = ["Wallet": 42, "Bank": 152]

// Create empty ones with the following syntax.
let emptyArray = [String]()  // init empty array consisting of strings
let emptyDictionary = [String: Float]()
