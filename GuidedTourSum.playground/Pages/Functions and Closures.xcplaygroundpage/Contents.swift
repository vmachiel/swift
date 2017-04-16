// Functions are declared with func and you state the parameters and types and the 
// return type
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)"
}
greet(person: "Bob", day: "Wednesday")

// You can use custom parameter tags, so you can use a different parameter name inside
// the function, and a different tag when you call the function for clarity. 
// You can also add a _ before the parameter definition if you want to be able to 
// omit it when you call the function. THIS IS ALL FOR CLARITY!
// Example: 'person' can be omitted, and day is used inside the function and called
// 'on' when calling the function:
func greet (_ person: String, on day: String) -> String {
    return "Hi \(person) today is \(day)"
}
greet("Henk", on:"Wednesday")  // easy to read later! 

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
// And a more consice way if the return type is already known.
numbers = [4, 99, 23, 22, 0, 64]
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// And even shorter if the closure is the only function argument
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)



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
    let sum = closure(4, 5) //the closure is executed here
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

