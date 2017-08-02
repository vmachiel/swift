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















