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
let six = Rank.six
six.rawValue
six.simpleDescription()
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
    print(threeDescription)
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

// One more thing: you can use the value of a enum case in logic by using the where keyword
// You assign the value of speed with let
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}
// Remember: switch go in order: so place the special .speed case before the general one!
func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "Meh"
    case .wind, .cloud:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}
print(getHaterStatus(weather: WeatherType.wind(speed: 5))!)

// or something like
if let haterStatus = getHaterStatus(weather: .wind(speed: 15)) {
    print("They are kinda like: \(haterStatus)")
} else {
    print("They ain't hating!")
}



// Recursive Enums
// Enumcases can have another case of that same enum as it's ass. value or as a case
// Write indirect before the cases that are recursive:
enum ArithmeticExpressionEx {
    case number(Int)
    indirect case addition(ArithmeticExpressionEx, ArithmeticExpressionEx)
    indirect case multiplication(ArithmeticExpressionEx, ArithmeticExpressionEx)
}
// or just write indirect before enum to indicate that all cases could be recursie:
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
// You can nest more of them inside each other: here's an (5 + 4) * 2 example:
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// write an eval function like this, which is recursie itself!
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
evaluate(product)






// Structs! Basic struct syntax: no need for init like classes
struct Card {
    var rank: Rank  // These are you self made enums!
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let theAceOfSpace = Card(rank: .ace, suit: .spades)
let cardDescription = theAceOfSpace.simpleDescription()

// See struct page!








// See slides for mutating func and computed var examples. 











