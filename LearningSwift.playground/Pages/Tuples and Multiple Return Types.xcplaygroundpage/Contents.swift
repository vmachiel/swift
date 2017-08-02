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