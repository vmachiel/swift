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

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark









