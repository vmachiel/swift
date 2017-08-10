// Strings are made off Unicodes, but there are also Character s
// Characters is what a human would see a a char. 
// Swift 3, one character may be made up of different parts, so if you
// count an emoji you get more than one somethings. In Swift 4, one char
// counts as one.

// Swift 3:
let testEmoji: String = "👨‍👩‍👧"
testEmoji.characters.count  // 3

// Swift 4:
// testEmoji.count

// In swift 3, strings aren't collections/sequences. They are in swift 4!
// So to access the caracters in 3, you do string.characters.whatever or
// for char in string.characters
for char in testEmoji.characters {
    print(char)
}



// Examples Swift 3
var s = "hello there"
for c in s.characters {
    print(c)
}
let count = s.characters.count
// Find the index of a certain char
let firstSpace: String.Index = s.characters.index(of: " ")!
// This returns an optional in case there is no space.

// You can use this to perform useful actions actions
if let firstSpace = s.characters.index(of: " ") {
    // insert collection of characters at an index
    s.insert(contentsOf: " you".characters, at: firstSpace)
}
print(s)

// Swift 4
// CHANGE HERE!!


// Getting a char can be done with [] but the index is not an int!
// It's actually a String.Index. This is because it counts human understandable
// caracters, which can be made up of different unicode points.
// Strings have properties called startIndex and endIndex of type String.Index
// If string is empty, these are equal.
// Types are added for clarity
let s2: String = "hello"
let firstIndex: String.Index = s2.startIndex
let firstChar: Character = s2[firstIndex]  // NOT AN INT!
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
dogString.characters.count  // 3 letter, one double ! and emoji
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}


// Insert the whole story of Substring and why it's there (ARC) when Swift 4 is final. 









