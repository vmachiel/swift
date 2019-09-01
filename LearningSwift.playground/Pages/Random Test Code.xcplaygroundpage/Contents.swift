
struct Card: Hashable {
    
    // MARK: Card properties
    // Is a card Face up? Is it matched? Is it been seen before? What's its ID
    var isFaceUp = false
    var isMatched = false
    var seenBefore = false
    private(set) var identifier: Int
    // !!No image or emoji: it's a model, and it's UI independent!!
    
    // MARK: Initing a new card with unique ID.
    // Private: internal implementation.
    // The Card type's count of id numbers.
    // This is static, and applies to the type, not the instance. So throughout the app,
    // this number is the same of all cards (and used to create unique ones below here)
    private static var identifierFactory = 0
    // MARK: Init
    // Now, structs are inited automatically, but you want to init the ID seperate.
    // Create an init that takes a parameter to init identifier. The rest are auto inited.
    // Use self to distinguish between a self.identifier of a parameter.
    // So for each new card, a new unique id is made, based on the static identifierfactory. It's
    // properly incremented so each new card gets a unique number upon init.
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    // MARK: Methods
    // Static function (works on the TYPE Card, not instance, that returns a unique ID)
    // Increments the Card type's unique number and returns it
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1  // No Cards. is needed: you're in a static method so access static vars
        return identifierFactory
    }
    // make it hashable.
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

let x = Card()
let y = Card()

x == y
