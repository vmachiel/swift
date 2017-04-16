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
// These have NO rawValue, and are their own values
// You can assign value or values if you want. In the case of Cheque, you need to supply an
// int for example.
enum PaymentMethod {
    case Cash // No extra data needed.
    case Cheque(Int) // Cheque #.
    case Card(cardType: String, cardNumber: Int) // 2 pieces of extra data.
}
var payExample = PaymentMethod.Cash
var payExample2 = PaymentMethod.Cheque(52)


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
        case .ace:
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












