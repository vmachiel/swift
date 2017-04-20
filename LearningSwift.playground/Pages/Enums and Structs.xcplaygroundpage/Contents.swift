// enums are a sort of blueprint. Classes and structs represent data, while
// enums are often used to limit the value of a variable to a set number of options
// You don't have to provide a value for each case: cases are be their own value!!!
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
// These have NO rawValue, and are their own values

// You can also state that each case DOES get a raw value.
// And you can make the compiler assign them implicitely:
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune  // venus = 2 etc
}
// You can define them on one line
enum WeekDay {
    case monday, tuesday, wednesday, thursday, friday
}



// You use enum values mainly with the switch statement.
var today = WeekDay.tuesday
switch today {
case .monday, .tuesday, .thursday:
    print("you have class")
case .wednesday:
    print("study day!")
default:
    print("Weekend!")
}
// you can define functions too!
enum Rank: Int {
    // the enum has been typed as an Int, so it'll autocomplete the rawValues
    // It normally starts and 0, but you can define the first case as something else
    // and it'll increment from there
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:  // use the .ace notation because the self is known to be Rank
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
ace.rawValue
ace.simpleDescription()
let five = Rank.five
five.rawValue
five.simpleDescription()
let queen = Rank.queen
queen.rawValue
queen.simpleDescription()
// And one more example with rawValues:
enum State: Int {
    case ready = 0
    case set
    case go
}
var raceState = State.ready
raceState.rawValue // 0
var nextRaceState = State(rawValue: raceState.rawValue + 1)
nextRaceState?.rawValue  // You need the ? in case there is no rawValue match. Since you 
// made nextRaceState from a rawValue operation. 
// Here's one more example with the Rank enum
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
// Code for the Suit to be used in the struct later:
enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}

// You can assign value or values if you want. In the case of Cheque, you need to supply an
// int for example.
enum PaymentMethod {
    case cash // No extra data needed, cash is its own value
    case cheque(Int) // Cheque #. own value, must be Int
    case card(cardType: String, cardNumber: Int) // 2 pieces of extra data.
}
let payExample1 = PaymentMethod.cash
let payExample2 = PaymentMethod.cheque(52)
let payExample3 = PaymentMethod.card(cardType: "Visa", cardNumber: 1234567890)

// you can use swith statements to take different types of actions. Swith pay Example to
// 1, 2 and 3 see what happens.
switch payExample3 {
case .cash:
    print("Client paid in cash")
case let .cheque(ammountPaid):  // use let to assign the Int variable to ammountPaid
    print("Client paid with a cheque of \(ammountPaid)")
case let .card(cardType, cardNumber): // use let to assign the cardType can cardNumber
    // to the same named parameters.
    print("The client paid with a \(cardType), card with number: \(cardNumber)")
}


// Structs! Basic struct syntax

struct Card {
    var rank: Rank  // These are you self made enums!
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let theAceOfSpace = Card(rank: .ace, suit: .spades)
let cardDescription = theAceOfSpace.simpleDescription()

// Classes vs structs
// Classes and structures in Swift have many things in common. Both can:
//
// Define properties to store values
// Define methods to provide functionality
// Define subscripts to provide access to their values using subscript syntax
// Define initializers to set up their initial state
// Be extended to expand their functionality beyond a default implementation
// Conform to protocols to provide standard functionality of a certain kind
// For more information, see Properties, Methods, Subscripts, Initialization, Extensions, and Protocols.
//
// Classes have additional capabilities that structures do not:
//
// Inheritance enables one class to inherit the characteristics of another.
// Type casting enables you to check and interpret the type of a class instance at runtime.
// Deinitializers enable an instance of a class to free up any resources it has assigned.
// Reference counting allows more than one reference to a class instance.

// Structers are always passed around when copied, classed passed by reference!!!!




