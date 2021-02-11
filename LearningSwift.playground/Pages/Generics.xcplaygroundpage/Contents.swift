import UIKit
// Generics are functions that can be applied to different types, which are specified
// later.
// Take the filter ints function:
func filterInts(_ numbers: [Int], _ includeNumber: (Int) -> Bool) -> [Int] {
    var result: [Int] = []
    for number in numbers {
        if includeNumber(number) {
            result.append(number)
        }
    }
    return result
}
// and its evenNumbers filter:
func divisibleByTwo(_ number: Int) -> Bool {
    return number % 2 == 0
}
// Let's say you want to filter strings based on their lenght
// Strings shorter than lenght 5 should be returned. A filter may look like
func shortName(name: String) -> Bool {
    return name.count < 5
}
// You can rewrite the filterInts function to filterStrings, where you can put in an array
// of strings and desired string filter:
func filterStrings(_ strings: [String], _ includeString: (String) -> Bool) -> [String] {
    var result: [String] = []
    for string in strings {
        if includeString(string) {
            result.append(string)
        }
    }
    return result
}
// You can keep doing this for each type, but as you use other classes and make your own
// this will be cumbersome. You can write a generic function that takes and array of any
// type and returns a filtered array of that type. You fill in a generic type parameter 
// (called element) which can be specified later. Use generic sounding names!
func filter<Element>(_ source: [Element], _ includeElement: (Element) -> Bool) -> [Element] {
    var result: [Element] = []
    for element in source {
        if includeElement(element) {
            result.append(element)
        }
    }
    return result
}
// You can call it like it is. No need to specify the type, since it will infer
// it from what you pass in. 
let numbers = [43, 235, 234, 1, 34, 100]
let names = ["Snorsex", "Henk", "Barry", "Ike", "BlaBlaBla"]
let evenNumbers = filter(numbers, divisibleByTwo)
// or
let evenNumbers2 = filter(numbers) {$0 % 2 == 0}
// And:
let shortNames = filter(names, shortName)
// or
let shortNames2 = filter(names) {$0.count < 5}
print(shortNames, shortNames2)


// filter is actually a method which can be called on arrays containing standard
// lib types. Map as well, both take closures as arguments see Functions and Closures. 





// More Generics examples:
// The swap function that uses inout parameters and "Pointers": 
var a = 4
var b = 9

func swapInts(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}
// You pass a "pointer" to the function when calling it, using &:
swap(&a, &b)
print(a)
print(b)
// And the Generic version
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}
var someString = "Hello"
var someOtherString = "Snor"
swapValues(&someString, &someOtherString)
someString
someOtherString


// Another: Generic version of popping, and pushing stuff on/off the stack
let image1 = UIImage(named: "stackPushPop_2x")
struct Stack<Element> {
    
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("Snor")
stackOfStrings.push("Sex")
stackOfStrings.push("Henk")
stackOfStrings.push("Bert")

stackOfStrings.pop()

for element in stackOfStrings.items {
    print(element)
}

// Extend generic:
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}













