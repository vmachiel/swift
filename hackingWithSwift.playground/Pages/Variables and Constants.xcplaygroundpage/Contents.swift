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

// IMPORTANT!! Always use the FIRST instead of the second because it's clearer:
let daysPassed = 546
var weeksPassed: Int
weeksPassed = 78
//This is possible but not preferred:
let yearsPassed: Double = 1.495890411

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

// Boolean
var stayOutTooLate: Bool
stayOutTooLate = true
var missABeat: Bool
missABeat = false

// Arrays are created like this. They are accessable by index
var evenNumber = [2, 4, 6, 8]
var songs = ["Snor", "Barry", "Henk", "Fred"]
songs[0]
songs[2]
type(of: songs)

// They can be stated explicitely to hold only one datatype, or you can state
// they should hold mixed
var songs2: [String] = ["Shake it Off", "You Belong with Me", "Back to December"]
var songs3: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

// Creating empty arrays. This won't work because it's not initialized. 
var songs4: [String]                                    // --> see!!
// You can do them like this (second one is mostly used)
var songs5: [String] = []
var songs6 = [String]()

// Dictionaries: key: value. Can't access by index.
var person = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December",
    "website": "taylorswift.com"
]
person["last"]








