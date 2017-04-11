// enums are a sort of blueprint. Classes and structs represent data, while
// enums are often used to limit the value of a variable to a set number of options
// You don't have to provide a value for each case: cases are be their own value
// unless you assign something to them.
// Take this example
enum CardSuit {
    case clubs
    case diamonds
    case spades
    case hearts
}
// use them like this:
var testDeck: CardSuit
testDeck = .diamonds
print(testDeck)
// or
var testDeck2: CardSuit
testDeck2 = CardSuit.spades
print(testDeck2)
// or
var testDeck3 = CardSuit.clubs
print(testDeck3)

// You can assign value or values if you want. In the case of Cheque, you need to supply an
// int for example.
enum PaymentMethod {
    case Cash // No extra data needed.
    case Cheque(Int) // Cheque #.
    case Card(cardType: String, cardNumber: Int) // 2 pieces of extra data.
}

// If cases don't get values attached, you can define them on one line
enum WeekDays {
    case monday, tuesday, wednesday, thursday, friday
}

// You can also state that each case DOES get an raw value.
// And you can make the compiler assign them implicitely:
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune  // venus = 2 etc
}

// You use enum values mainly with the switch statement. 
switch today