import UIKit
// declare variables with var and constants with let. Use var only when declaring, not reasigning.
// Types can be stated at declaration or inferred, and check with the following syntax
let testVar = 42
var name = "Barry"
name = "Machiel van Dorst"
type(of: name)
// Data Types and Classes start with a Capital letter, variables do not. They do have camelCase

// Initialize empty variables by stating their type:
var age: Int
age = 29

// Float and Double (you know this) Apple recommends Double by default. (64 vs 32-bit)
var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -86.783333  // Notice the last digit is missing due to Float limitations -->
longitude = -186.783333  // You quickly lose accuracy                                -->
longitude = -1286.783333  // If you change to Double this won't happen
longitude = -12386.783333
longitude = -123486.783333
longitude = -1234586.783333

