import Foundation

// Hello world is easy, complete with autonewline! 

print("Hello World")
print("😃")  // Unicode friendly! 
// Variables are declared once with "var" and constants with "let
// When you assign a new value to a variable it needs to be of the same type

var myVariable = 42
myVariable = 51
print(myVariable)
let myConstant = 51.2

// Compiler can infer the type at initialization. You can also
// explicitely define it. You must also define conversion to another
// type if needed!

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


// Arrays and Dicts are declared with [] any are both ordered.
// Acces them with indecis, and a comma is allowed at the end.
// Again, types are inferred
var shoppingList = ["Bananas", "Yogurt", "More stuff",]
var ammountOfCash = ["Wallet": 42, "Bank": 152]

// Create empty ones with the following syntax.
let emptyArray = [String]()  // init empty array consisting of strings
let emptyDictionary = [String: Float]()

// empty existing ones like:
shoppingList = []
ammountOfCash = [:]

//



// Extra: Set is an unorderd collection of unique items of any type. Can be iterated
// over. Basically, I see it as a dict with keys only. They need to be hashable as well.
// Create one:
let emptySet = Set<Int>()
// or fill one directly:
var setExample: Set = [4, 5, 2, 1]
setExample.insert(3)
for item in setExample {
    print(item)  // random order.
}
setExample.contains(3)
setExample.isEmpty

// More:
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true







// Declare variables with var and constants with let. Use var only when declaring,
// not reasigning.
// Types can be stated at declaration or inferred, and check with the following syntax
let testVar = 42
var name = "Barry"
name = "Machiel van Dorst"
type(of: name)
// Data Types and Classes start with a Capital letter, variables do not.
// They do have camelCase

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
// Append/change items like this:
evenNumber.append(10)
evenNumber.append(contentsOf: [12, 14, 16])
songs[2] = "HenkBert"
// Change items using ranges. You can even change a certain range to a range
// of different lenght
songs[0...2] = ["Snorsex", "Barrynac", "HenkBert2"]
songs[2...3] = ["Freddy", "Snorrie", "Lorry"]  // change the last 2 items into 3
// items, changing the lenght of the array.
print(songs)

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
person["last"]  // retrieve value for key
person["first"] = "Barry"  // change value
person["age"] = "25" // has to be string

// Optional value of dictionary, maybe there is one, maybe there isn't
let personDay: String? = person["day"]
if personDay == nil {
    print("no day was found")
}
// Specify what dictionary key and value types you want to use if you
// want to init a empty dict of specific contents
var operations: Dictionary<String, Double>
// Dicts can have a willSet and didSet property for code to be executed before
// or after an entry is added/removed.




// When dealing with tuple types, access their elements like this:
let tupleType: (Int, String)
tupleType = (29, "Machiel")
print("My name is \(tupleType.1) and I'm \(tupleType.0) years old")
// or name them:
let tupleType2: (age: Int, name: String)
tupleType2 = (23, "Barry")
print("My name is \(tupleType2.name) and I'm \(tupleType2.age) years old")
// Comparing tuples
(1, "zebra") < (2, "apple") // true because 1 is less than 2;
                            // "zebra" and "apple" are not compared
(3, "apple") < (3, "bird")  // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")    // true because 4 is equal to 4, and "dog" is equal to "dog"


// Any and AnyObject:
// Are there for Obj-C compat, but their API have been updated in the mean time.
// Any holds any type (also class) and AnyObject holds any class. Avoid these though: 
// Swift is strongly typed, and Any/AnyObject need to be converted to types before 
// you can invoke methods on them.

// Any can be used for example with multiple ViewControllers: Any kind of type can cause a
// change of viewController to happen. Might be a button, or a cell ect. So the method to
// change must take any type. Any would be an optional in that cause, because the sender
// might not be specified. AnyObject can be used to create an array with mixed types.
// AVOID THIS: use an enum to specify what type etc. 

// To use data of type Any, convert it by casting it to another type. 
let unknown: Any = 5  // this is an Int

if let stringExample = unknown as? String {
    print(stringExample)
}
if let intExample = unknown as? Int {
    print(intExample)
}

// Type alias:
typealias WholeNumber = Int
let aNumber: WholeNumber = 49











