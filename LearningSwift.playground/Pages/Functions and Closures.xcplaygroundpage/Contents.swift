// Functions are declared with func and you state the parameters and types and the 
// return type
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)"
}
greet(person: "Bob", day: "Wednesday")

// You can use custom parameter tags, so you can use a different parameter name inside
// the function, and a different tag when you call the function for clarity. (2nd parameter)
// You can also add a _ before the parameter definition if you want to be able to 
// omit it when you call the function. THIS IS ALL FOR CLARITY! (1st parameter)
// Also, default values work similar to python (3rd parameter)
// Example: 'person' can be omitted, and day is used inside the function and is labelled
// 'on' when calling the function. shouting has a default of false
func greet(_ person: String, on day: String, shouting: Bool = false) -> String {
    var message = "Hi \(person) today is \(day)"
    if shouting {
        message = message.uppercased()
    }
    return message
}
greet("Henk", on:"Wednesday")  // easy to read later! : no person label, on instea of day,
// and shouting can be omitted because of the default

// Return multiple values using a tuple. They can be adressed with both name and index
// Also assign the return value(s) to a variable
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    // initial values, made with array values
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [4, 130, 34, 9, 11, 94])
statistics.sum  // access by name!
statistics.2    // access by index!

// Variable number of arguments (*args) which are use as an array in the func
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for num in numbers {
        sum += num
    }
    return sum
}
sumOf()  // called with 0 argumens
sumOf(numbers: 4, 6, 123, 23)  // called with 4 arguments




// Function types: specify a function as a type for a variable:
func addTwoNumbers(_ a: Int, _ b:Int) -> Int {
    return a + b
}
let mathFunction: (Int, Int) -> Int = addTwoNumbers
// This variable can now be used like this:
print("The result of adding 2 and 3 is: \(addTwoNumbers(2, 3))")




// Nested functions: inner functions have access to variables of the outer.
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

// And just like python, they are first class citizens, so they can be a return func and
// be a closure
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var incrementer = makeIncrementer()
incrementer(8)
// or a version where you set the ammount to be added:
func incrementBy(adder: Int) -> ((Int) -> Int) {
    func addAdder(number: Int) -> Int {
        return adder + number
    }
    return addAdder
}
var incrementer2 = incrementBy(adder: 4)
incrementer2(5)

// Functions can take functions as one of their arguments, like the condition argument. 
// You don't include () when passing a function: you're not executed it, just passing it
// to the main function so it can use and execute it.

// So for each item in the list, pas it to condition. If one of them returns true, return true
// The lessThanTen function is passed, so each number in the list gets checked, if one
// is smaller than 10, the whole thing returns true
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [44, 66, 23, 1, 69, 349]
hasAnyMatches(list: numbers, condition: lessThanTen)
// Another example here is a function that checks if a number is divisible by two:
func divisibleByTwo(_ number: Int) -> Bool {
    return number % 2 == 0
}
// And this function takes a list of numbers and a criteria, and any number that meets
// the criteria gets added to a list that gets returned.
func filterInts(_ numbers: [Int], _ includeNumber: (Int) -> Bool) -> [Int] {
    var result: [Int] = []
    for number in numbers {
        if includeNumber(number) {
            result.append(number)
        }
    }
    return result
}
let evenNumbers = filterInts(numbers, divisibleByTwo)




// Closure 1: closure expressions 1

// Function are special closures. Closures have access to variables and function in
// the scope they were created in, as well as their own, even if they are in a different scope
// when executed!!
// You can write one (a closure that is) withouth a name by surrounding it with ({}).
// seperate the arg/return type from the body with 'in'
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})
// so for each element in numbers map the following function: take the humber, 
// multiply *3 and return it. Here is one that returns false if the number is odd
// and true if even
numbers.map({ (number:Int) -> Bool in
    return number % 2 == 0
})
// And a more consice way if the argument type or return type is already known.
// Also, it's only 1 return statement so return can be omitted.
numbers = [4, 99, 23, 22, 0, 64]
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// And even shorter if the closure is the only function argument: no parans
let mappedNumbers2 = numbers.map { number in 3 * number }
// Or resplace the arguments with $0, $1 etc
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)

// Here is the filterInts function from before, but with the the divisibleByTwo function
// as a closure expression. You don't need that as a function a lot:
let numbers2 = [44, 32, 11, 49491, 0, 94]
var evenNumbers2 = filterInts(numbers2, {(number: Int) -> Bool in return number % 2 == 0})
evenNumbers2
// you can again! write it more conceice (however you spell that)
evenNumbers2 = filterInts(numbers2, {(number) in return number % 2 == 0})
// and shorter again, if it's only one return statement:
evenNumbers2 = filterInts(numbers2, {(number) in number % 2 == 0})
// and shorter again by using $0 for the first argument $1 for the second etc:
evenNumbers2 = filterInts(numbers2, {$0 % 2 == 0})
// or write it outside the parenthasis when it's the last argument: trailer closure:
evenNumbers2 = filterInts(numbers2) {$0 % 2 == 0}



// CLOSURE 2
// A closure is basically a portable function. For example, the following function 
// that adds 2 numbers.
func add(num: Int, num2: Int) -> Int {
    return num + num2
}
// If you were to declare a closure like above, it would be like this.
// Notice the type of the closure. It accepts 2 integers that return an integer.
let someClosure: (Int, Int) -> Int = { (num, num2) in
    return num + num2
}
// You can also pass closures to functions. Here's the function declaration 
// that accepts a parameter closure that accepts 2 integers and returns an integer:
// it also takes one more interger and finally returns a string.
func usingClosures(closure: (Int, Int) -> Int, devider: Int) -> String {
    //other stff
    let sum = closure(16, 5) //the closure is executed here
    let final = sum / devider
    return "The final product is \(final)"
}
usingClosures(closure: someClosure, devider: 3)

// When you call the function, you can basically write the closure inside the parameter. 
// Closures must be inside curly braces, unless it's a trailing closure.
//something({ num1, num2 in
//return num1 + num2
//})

// Trailing closure works if the closure is the last or only parameter
//something2() { num1, num2 in
//    return num1 + num2
//}
// These are dumb examples, but a good use of a closure is when you're making an
// API call and want part of code to execute ONLY if the data call works. For example:
// func makeAPICall(using: String, completion: () -> Void) {
    //Run some call asynchronously using NSURLSession
    //Reach this point if it worked
    // completion
// }
// And when you call the function, you can use a trailing closure to tell it what to do.

// makeAPICall(linkString) { in
    //code in here will run only if the api call succeeds
    //Like updating the view
// }


// Example of the filter method: generic method that can be called on the arrays
// of standard lib types. It takes a closure as an argument
let names = ["snor", "barry", "Machiel", "kaljdflkasdjf", "kees"]
let shortNames = names.filter{$0.characters.count < 5}
shortNames

// Example of the map method: it maps a given closure to each element of the array:
let upperCaseNames = names.map {name in name.uppercased()}
upperCaseNames
// Or do them both, with . syntax
let bothFilters = names.filter {$0.characters.count < 5}.map {name in name.uppercased()}
bothFilters

