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

// You can 