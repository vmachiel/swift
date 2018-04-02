// Optionals are a enum with two cases and a generic asso value:
enum OptionalExample<T> {
    case none
    case some(T)
}

let optional1: String? = nil
// equavalent to:
let optional2 = OptionalExample<String>.none
// and
let optional3: String? = "Hello"
// equavalent to:
let optional4 = OptionalExample<String>.some("Hello")

let unwrappedOptional1 = optional3!
// Force unwrapping is equ to:
switch optional4 {
case .some(let value):
    let y = value
    print(y)
case .none:
    print("This will raise an exception!!!")
}

// if let like this:
if let value = optional3 {
    print(value)
}
// is equ to this:
switch optional4 {
case .some(let value):
    let z = value
    print(z)
case .none:
    break
}


// Optinal return types: write a ? after one or more of the return types to indicate it
// might be nill. See this example, which returns a string if one string of the array has
// the desired prefix, and returns nil if none are found.
// It must be unwrapped before you can use it!
func firstString(havingPrefix prefix: String, within strings: [String]) -> String? {
    for string in strings {
        if string.hasPrefix(prefix) {
            return string
        }
    }
    return nil
}
firstString(havingPrefix: "snor", within: ["Hallo", "Snorsex", "snorsex",])
firstString(havingPrefix: "barry", within: ["Hallo", "Snorsex", "snorsex",])

// You can call functions with optional return types in a if let statement, since those
// check wether the value is there of if it's nill
// It temporarely makes the value of an optional availible via a temp variable/constant
// IF there is one.
var guests = ["Barry", "Harry", "Larry", "Darry"]
if let bGuest = firstString(havingPrefix: "B", within: guests) {
    print("Guest with B was found: \(bGuest)")
} else {
    print("No Guest with B was found")
}




// Make sure if you assign return value to variable, you make it optional if you declare it
// separately.
func getHaterStatus(weather: String) -> String? {
    if weather == "Sunny" {
        return nil
    } else {
        return "Hating"
    }
}
var areTheyHating: String?  // The questionmark is necessary
areTheyHating = getHaterStatus(weather: "Sunny")  // may or may not be variable

// Optional binding:
if let haterStatus = getHaterStatus(weather: "Rainy") {
    print("They hating..")
} else {
    print("Must be sunny outside")
}

// Forced unwrapping, get rid of the safety and assume there is a variable. 
// Do this by adding !
func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }
    return nil
}

var year = yearAlbumReleased(name: "Red")
// Check if it's nil, if it's not it's a value so you can force unwrap it
if year == nil {
    print("There is no release date for this album")
} else {
    print("The release date was \(year!)")
}
// That was forced unwrapping! , but declaring a variable as String! makes it implicitely unwrapped
// (See below). These can be used without further checking
// You would use this with Apple APIs (Because lecagy), or with UI elements. 

// Optional chaining: Only run certain code if optional has a value
// You can put . syntax after the ?, which will only run if the optional contains a value
// The optional is unwrapped and processed if value, nothing is done if no value. 
// You can chain them like optionalValue?.doSomething?.doSomethingElse ect. It'll stop 
// once it encounters a nil
// It needs to be an optional each time though.
func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}
let album = albumReleased(year: 2006)?.uppercased()

// And finally nilcoalescing. ?? syntax: if optional is availible use if if not, use 
// the value after the ??
let album2 = albumReleased(year: 2006) ?? "unknown"
let album3 = albumReleased(year: 492) ?? "unknown"  //  -- > see!!

// Some more examples of optional chaining:
// Two  arrays of string optionals, and those are put into an array themselves.
// That container's type is also optional.
let arrayOfOptionals: [String?]
let arrayOfOptionals2: [String?]
arrayOfOptionals = ["hello", nil, "goodbye", "henk"]
arrayOfOptionals2 = [nil, nil, "friet", nil]
let arrayOfOptionalsContainer: [[String?]?]
arrayOfOptionalsContainer = [arrayOfOptionals, arrayOfOptionals2, nil]
// If you think the second array may be there, and it may have a string
// at it's third index (2), you can check without crashing if it's not there.
// And do something with it.
if let arrayIsFound = arrayOfOptionalsContainer[1]{
    if let elementIsFound = arrayIsFound[2] {
        print(elementIsFound.uppercased())
    }
}
// But you can also chain the optionals. So If the 2 array is found, and it's
// third element is found, applay the method.
let upperCasedStringFound = arrayOfOptionalsContainer[1]?[2]?.uppercased()
// This is still an optional, you can also set it to a string directly:
if let x = arrayOfOptionalsContainer[1]?[2]?.uppercased(){
    let upperCasedStringFound2 = x
    print(upperCasedStringFound2)
}
// Nothing will go wrong is value is missing, will just be nil.
let upperCasedStringFound3 = arrayOfOptionalsContainer[1]?[3]?.uppercased()
// Apply this in cases like: if a label is found, and is has text, uppercased it.


// Using guard:
// You can use a guard statement with optionals. The expression after the guard is 
// executed, or at least tried. If it failed because of a nil value in an optional, the
// else block is executed. You do this in a function, and the else block must exit the
// function. So you "guard" the function from nil values being use and thus crashing it.
var optionalNumber: Int?
optionalNumber = 23

func triplePossibleNumbers(maybeNumber: Int?) {
    
    guard let number = maybeNumber else {
        print("number provided was nil")
        return
    }
    print("\(number * 3)")
}
triplePossibleNumbers(maybeNumber: optionalNumber)





// Optionals from Apple's docs: They either have a value that you can unwrap to access it or it's
// empty
let possibleNumber = "123" 
let convertedNumber = Int(possibleNumber)  // Either and Int or Nil so:
type(of: convertedNumber)

// They can also be nil:
let serverCodeRespone: Int?
serverCodeRespone = nil
// This was not necessary: if no value is specified for an optional, its a type Int? with
// value nil
type(of: serverCodeRespone)  // still classified as Int?

// or something like:
if convertedNumber != nil {
    print("It was a number, and its value is \(convertedNumber!)")
}

// Optional binding: if an optional has a value, assign it to a temp constant/variable with
// let/var, and execute code. If not, execute else block:
if let actualNumber = Int(possibleNumber) {
    let absoluteNumber = abs(actualNumber)
    print("The square of the absolute value of the number was \(absoluteNumber * absoluteNumber)")
} else {
    print("Ther was no number found")
}

// You can chain as main if let, if vars that you want.
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

// Forced unwrapping: If you are sure there is a valid int in there you can force unwarp it
// Compiler treats it as a Int, so make sure there
let actualInt = convertedNumber!
// Now you can use it without unwrapping it first. 

// Implicit unwrapping.
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark to unwrap/use

// When a type is normally and optional (Like UILabel) But you know it's always there
// You can unwrap it at declaration: implicitely unwrapping.
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark



// And another example of optional chaining: 
class Room {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Residence {
    
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Address {
    
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class Person {
    var residence: Residence?
}


let personExample = Person()
var residenceExample = Residence()
let addressExample = Address()

addressExample.buildingName = "Henk Building"
addressExample.buildingNumber = "45"
addressExample.street = "Snor Street"
let room1A = Room(name: "1A")
let room1B = Room(name: "1B")
let room2A = Room(name: "2A")
let room2B = Room(name: "2B")

residenceExample.rooms.append(room1A)
residenceExample.rooms.append(room1B)
residenceExample.rooms.append(room2A)
residenceExample.rooms.append(room2B)
residenceExample.address = addressExample
personExample.residence = residenceExample

// Here you go
personExample.residence?.address?.buildingNumber
personExample.residence?.rooms[2]













