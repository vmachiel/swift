// Error handeling is often done by creating an enum that adopts the error protocol
enum PrinterError: Error {
    case outOfPaper
    case outOfToner
    case onFire
}

// Write throw to throw and error and throws to indicate a function can throw one
// The code calling the function, should deal with the error if its thrown
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never has toner" {
        throw PrinterError.outOfToner
    }
    return "Job Sent"
}

// To call code that may throw and error write a do block. Mark the part that can throw
// the actual error with try, and what should be done if a error is raised with catch.
// You can write several catch statements for different raised errors like a switch
// statement
do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {  // Specific code 
    print("This. Printer's on fijaaaahhhh")
} catch let printererror as PrinterError {  // assing the thrown error to a constant en use it
    print("Printer Error!: \(printererror)")
} catch {  // general error handeling. 
    print(error)
}

// You can use optionals to run a function that throws an error. If it's trown, the result
// is nil, otherwise its the returned value:

let printerSuccess = try? send(job: 1234, toPrinter: "Snor Printer")
let printerFailure = try? send(job: 394, toPrinter: "Never has toner")

// And finally, you can write defer to specify code that is run at the end of a function,
// regardless if any error is thrown. It's the "finally" in "try, except, finally" 
// from python

var fridgeIsOpen = false
let fridgeContents = ["milk", "eggs", "leftovers"]

func fridgeContainsFood(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false   // always closes the door whatever happens!
    }
    
    // Check if the kind of food is in the fridge
    let result = fridgeContents.contains(food)
    return result
}


// Optional trys
// Let's say to wanted to see just IF a function returns an error.
// Doesn't matter what the error is, just that it trown and error.
// Consider the following:
enum UserError: Error {
    case badID, networkFailed, iedereenOntploft
}

func returnUser(id: Int) throws -> String {
    print("doing some stuff, but o NO an error for demonstration purposes")
    throw UserError.networkFailed
}
// I want to know: does this give an error
if let user = try? returnUser(id: 33) {
    print(user)
}
// Nothing happes because it DID throw and error so no action taken.
// You write it like this if you just want to skip in case of error.
// You could also use ?? to provide a default value if an error is thrown
let user2 = (try? returnUser(id: 33)) ?? "No one"
// the point is: You DONT have to handle the errors, just move on if one is thrown or use default value




// Assertions: assert is a function that takes a closure, and a message. The closure 
// must return a bool. If the bool is false, the message will be printed and app will
// crash. Autoclosure so no {} necessary
assert(printerSuccess == "Job Sent", "The job wasn't sent! ")
// asserts can be left there, the version you submit to app store will NOT execute the
// asserts' closure or crash or print message in ANY case. 














