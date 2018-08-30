// Protocols specify requirements (abc like) that need to be implmented. Think of a
// board game where players and computers take turns. You can have a default Player class
// that is subclassed into HumanPlayer and ComputerPlayer. Player needs to specify that
// and instance can take a turn. But, humans and AI don't share behavior, and both over-
// ride the basic method. So you make Player into a protocol, which specifies that a 
// takeTurn method MUST be implemented, and the different subclasses can implement them
// in different ways.

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






