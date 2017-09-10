import Foundation
// A range is basically a struct that specifies a start and end index
// The generic type can be Int, double etc, but must be comparable!
// Range needs to make sure the start index < endindex
struct Range2<T> {
    var startIndex: T
    var endIndex: T
}
// Range<Int> could be used to specify the slice of an array!

// Slicing time!
// ..< is start excluding upper and ... is start including upper:
let array1 = ["a", "b", "c", "d", "e"]
let slice1 = array1[2...3]
let slice2 = array1[2..<3]
// Slicing out of bounds [6...8] or reversed [4...1] will cause a runtime crash

// If it's a Range with lower and upperbounds of type Int, like above,
// it's actually the more capable CountableRange type, or a sequence. You can
// then use the for in syntax, like seen in control flow:
for index in 0...4 {
    print(array1[index])
}
// You can't do this with floating numbers: they aren't CountableRange, but simple
// Range. If you want to do this, use builtin function stride like so.
// So this takes a type that can be used in a Range and returns a CountableRange
for index in stride(from: 0.5, to: 15.21, by: 0.3) {
    print(index)
}
// important: a stringsubrange is NOT Range<Int> but technically Range<String.Index>


// Arrays are sequences that can be iterated over:
let animals = ["Giraffe", "Cow", "Doggie", "Bird"]
for animal in animals {
    print(animal)
}
// Dicts as well, using tuples:
var pac12teamRankings = ["Stanford": 1, "USC": 11, "Cal": 12]
for (key, value) in pac12teamRankings {
    print("Team \(key) is ranked number \(value)")
}
// Also, when you access dict using keys, they return optionals of their value
// in case the key isn't in the dict.
let test1 = pac12teamRankings["Cal"]   // Int? with value 12
let test2 = pac12teamRankings["Snor"]  // Int? with value nil

// Arrays have closure method like filter:
// def filter is : filter(includeElement: (T) -> Bool) -> [T]
// filter takes one argument: a function that takes on element of the same type as
// the array, and returns if that should be included. filter returns an array with
// only the included items
let bigNumbers = [2, 47, 118, 5, 9].filter({ $0 > 20 })
// $0 > 20 is the includedElement function. Again, swift knows it returns a bool,
// knows that $0 is supposed to be only argument T
print(bigNumbers)

// Anotherone map: transforms each element into something different.
// map(transform: (T) -> U) -> [U] so takes one parameter: a function that takes 
// one and returns a transformed one. Applied on the whole array, transforms all
// of the elements. What the transformation function is can be passed as a closure:
let stringified = [1, 2, 3].map{ String($0) }
print(stringified)
// NOTICE THE LACK OF (): You can leave those at: see trailing closure syntax. 

// Finally: reduce takes all the elements and reduces them to a single value. 
// reduce takes two arguments: one "answer so far" and one function of what to do.
// THAT function takes two arguments: the "answer so far" and en element from the
// array and returns the new "answer so far". Finally, the whole thing returns a
// final answer: one value. U is "answer so far"'s type (inferred) and T
// is the current array element's type (can be different, is not in example)
// reduce(initial: U, combine: (U, T) -> U) -> U
let sum: Int = [1, 2, 3].reduce(0, { $0 + $1 })
// since + is a valid function it can be simply that instead of closure
let sum2 = [1, 2, 3].reduce(0, +)
let product = [1, 2, 3, 4].reduce(1, *)



// Useful method of dictionary: flatmap!
let dictTest = ["M": 4, "N": 5, "X": 48]
let x = dictTest.flatMap{"\($0), \($1)"}
x









