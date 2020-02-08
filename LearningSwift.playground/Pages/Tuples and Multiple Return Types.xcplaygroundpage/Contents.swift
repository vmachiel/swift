// Tuples are just a group of values. Use them anywhere you use a type.
// This one has a type of String, Int, Double
let tupleValues: (String, Int, Double) = ("Hello", 5, 0.58)
// They can be used to assign many variables at once (unpacking)
let (word, number, value) = tupleValues
print(number)
// You can access tuple values by index:
print(tupleValues.2)

// Or you can name tuples, which is preferred. 
let tupleValues2: (w: String, i: Int, v: Double) = ("Hello", 5, 0.58)
print(tupleValues2.w)
// you can stil unpack:
let (word2, number2, value2) = tupleValues2
// or you can even skip an unpack:
let (word3, _, value3) = tupleValues
// Now the second element of the tuple isn't set to a variable.
print(word3)
print(value3)

// As seen in functions, tuples can be return types: 
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



// You can use tuples to tests multiple values
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("It's on the origin")
case (_, 0):
    print("It's somewhere on the x asis")
case (0, _):
    print("It's somewhere on the y asis")
case (-2...2, -2...2):
    print("I'ts inside or one the box")
default:
    print("I'ts outside of the box")
}

// Using where in tuples:
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}















