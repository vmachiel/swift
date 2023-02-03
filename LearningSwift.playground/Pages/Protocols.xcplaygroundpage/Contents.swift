// Protocols specify requirements (abc like) that need to be implmented. Think of a
// board game where players and computers take turns. You can have a default Player class
// that is subclassed into HumanPlayer and ComputerPlayer. Player needs to specify that
// and instance can take a turn. But, humans and AI don't share behavior, and both over-
// ride the basic method. So you make Player into a protocol, which specifies that a 
// takeTurn method MUST be implemented, and the different subclasses can implement them
// in different ways.
// Protocols can inherit other protocols. Think classes without data.
import UIKit

class Board {
    
    var typeOfGame: String
    var numberOfPlayers: Int
    
    init(typeOfGame: String, numberOfPlayers: Int) {
        self.typeOfGame = typeOfGame
        self.numberOfPlayers = numberOfPlayers
    }
}

protocol Player {
    func takeTurn(on board: Board)
}
// So now you declare a human and AI player class, which must implement the takeTurn
// method. To this by "inheriting" the protocol. You don't write override, since you're
// implementing instead. You can make them both classes or structures.

// These are structs since you don't need multiple references to the same players
struct HumanPlayer: Player {
    var name: String
    var score: Int
    func takeTurn(on board: Board) {
        print("Take a turn on the board)")
    }
}

struct ComputerPlayer: Player {
    
    func takeTurn(on board: Board) {
        print("Bleep Bloop, I've taken my turn")
    }
}


// EXTRA: You can extend objects by implemeting protocols as well: 
// Do this to ORGANIZE YOUR CODE
extension HumanPlayer: CustomStringConvertible {
    var description: String {
        return "This player is named \(name) and has a score of \(score)"
    }
}

// Protocols are types. Vars can be of that type, which can be assigned something that
// conforms to that protocol
protocol Moveable {
    mutating func move(to point: CGPoint)
}

class Car: Moveable {
    
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func move(to point: CGPoint) {
        print("I've moved to \(point)")
    }
}

let prius = Car(name: "Car 1")
var somethingElse: Moveable //Protocols are types
somethingElse = prius  //TYPE IS Moveable

// somethingElse.name = "Car2"    Can't be done, it's not Car, its Moveable
prius.name = "Car 2"

print(prius.name)


// You can organize different types that do confirm to same protocol, into an array of
// the protocol type
struct Shape: Moveable {
    mutating func move(to point: CGPoint) {
        print("Moved to \(point)")
    }
}
let square = Shape()

var protocolArray = [Moveable]()
protocolArray = [square, prius]
// THEY CAN ONLY USE THE MOVEABLE funcs/vars: they are Moveable



// USES OF PROTOCOLS!!
// 1: Delegates. Views can send messages to a controller that implements a protocol
// Look up delegation!!

// 2: Dict keys need to be unique and hashable. Dictionary KEYS therefore implement the
// Hashable protocol, which implements the Equatable protocol. Equatale enforces that an
// item can be tested if it's equal to another item using == resulting in true or false
// Types of the two arguments are Self: if an Int implements this for example, type of
// the arguments are Int.
protocol Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool
}
// Hashable inherists that, plus enforces that an interger hash value can be derived from
// the object
protocol Hashable: Equatable {
    var hashValue: Int { get }
}
// So you get:
//Dictionary<Key: Hashable, Value>






// Protocol extentions!
// Thus you GAIN something if you confirm to that protocol
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
// These are of type Array and Set, both confirm to protocol Collection
extension Collection {
    func summarize() {
        print("There are \(self.count) of us.")
        
        for name in self {
            print(name)
        }
    }
}
pythons.summarize()
beatles.summarize()



// Protocolos can define a default implemtation by using an Extention
protocol Movable2 {
    func move(by: Int)
    var hasMoved: Bool {get}
    var distanceFromStart: Int {get set}
}
// Default implementation
extension Movable2 {
    var hasMoved: Bool {
        return distanceFromStart != 0
    }
}
// Now you can implement only the other two requirements
class Car2: Movable2 {
    var distanceFromStart = 0
    
    func move(by amount: Int) {
        distanceFromStart += amount
    }
}

// So now you can make an instance, without have to implement the distanceFromStart
var car2 = Car2()
car2.hasMoved // False
car2.move(by: -8)
car2.distanceFromStart // -8
car2.hasMoved //True
// You CAN override the default implemtation



// Protocol extentions
// You can override a larger protocol that different types adhere to
// So it has certain behavior that all types that adhere to the protocol inherit
extension Collection {
    var isNotEmpty: Bool {
        return isEmpty == false
    }
}
// Simple example that adds a nicer isNotEmpty attribute to all collections
// dict, array ect.

if beatles.isNotEmpty {
    print("Let's play!")
}
