// Strings are made off Unicodes, but there are also Character s
// Characters is what a human would see a a char. 
// In Swift 4, each char counts as one.

// Counting chars
let testEmoji: String = "👨‍👩‍👧"
testEmoji.count  // 4

for char in testEmoji {
    print(char)
}
// Basic string stuff
var s = "hello there"
for c in s {
    print(c)  // 11
}
let count = s.count
// Put characters of string in an Array:
let charArray = Array(s)


// Indexing
// Find the index of a certain char
let firstSpace: String.Index = s.firstIndex(of: " ")!
// This returns an optional in case there is no space.

// You can use this to perform useful actions actions: If space is found,
// insert something there
if let firstSpace = s.firstIndex(of: " ") {
    // insert collection of characters at an index
    s.insert(contentsOf: " you", at: firstSpace)
}
print(s)



// Getting a char can be done with [] but the index is not an int!
// It's actually a String.Index. This is because it counts human understandable
// caracters, which can be made up of different unicode points.
// Strings have properties called startIndex and endIndex of type String.Index
// If string is empty, these are equal.
// Types are added for clarity
let s2: String = "hello"
let firstIndex: String.Index = s2.startIndex  // NOT AN INT!
let firstChar: Character = s2[firstIndex]
// Get a index after a certain one:
let secondIndex: String.Index = s2.index(after: firstIndex)
let secondChar: Character = s2[secondIndex]
// Jump ahead and write it shorter:
let fifthChar: Character = s2[s2.index(firstIndex, offsetBy: 4)]

// And use ranges of String.Index
let firstTwoChars = s2[firstIndex ... secondIndex]


// String is a valuetype!!! So if you do let s = "hello" you can't mutate!
let hello = "hello"
// hello += "there" can't be done
var greeting = hello
greeting += " there"

// Some more stuff with UTF-8
let dogString = "Dog‼🐶"
dogString.count  // 3 letter, one double ! and emoji
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}




// String slicing creates a new type!!
let someStringToSlice = "One,Two,Three"
let listOfSlices = someStringToSlice.split(separator: ",")
// Its type is a substring:
type(of: listOfSlices)
// This is because of ARC: if it was a regular string you would have two refferences,
// to the original string: one from someStringToSlice, and one from listOfSlices.
// If the original strings goes out of scope, the whole string would be kept in
// memory. This can be bad if you are slicing small parts out of HUGE strings. So you
// can copy on write, but that has performance trade offs. So you use a new type
// Substring. This cause you to use a String contructor if you want to use the
// part you sliced. This will allow the original string to be destroyed, and the buffer
// is freed.
let firstSlice = listOfSlices[0]
let firstWord = String(listOfSlices[0])  // now it's a string.




// Range is generic, it doesn't have to be over strings. Can be over String.Index
let pizzaPlace = "Je moeders eettent"
if let someindex = pizzaPlace.firstIndex(of: "m") {
    let partOfPizzaPlace = pizzaPlace[someindex..<pizzaPlace.endIndex]
    print(partOfPizzaPlace)
}

