//
//  MemoryGame.swift
//  Memorize
//
//  Created by Machiel van Dorst on 06/07/2020.
//  Copyright © 2020 vmachiel. All rights reserved.
//

import Foundation

// The logic or Model of the game. It's generic until inited.
// The cards can be made with any type. 
struct MemoryGame<CardContent> {
    
    // MARK: - Properties
    // The actual cards. Inited when you make an instance of this model (in ViewModel)
    var cards: Array<Card>
    
    // MARK: - Init
    // Takes number of cards and uses a method and the <Type> in the ViewModel to create the cards.
    // The cardContentFactory method uses the index which we are currently at en returns something
    // of type CardContend of the type CardConent (String in this assignment)
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // empty arry of cards
        cards = Array<Card>()
        // Loop that creates the cards. The numberOfPairsOfCards is the upper bound 0..<N.
        // For each, the function cardContentFactory is defined in the ViewModel. There, the array
        // with possible emojis is defined and the closure that returns one eacht time you loop.
        // append two cards with the content set to the emoji that gets returned
        // THAT IS IN THIS CASE: the model is actual still generic and could contain any content. 
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            // ids need to be unique
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    // MARK: - Methods
    // Function that handles when a card is chosen. Mutating because struct. Changes the model
    // uses the index method to get the index of the passed card and flip it.
    mutating func choose(card: Card) {
        // TODO: remove this debug
        print("card chose: \(card)")
        let chosenIndex: Int = index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    // Takes a card. Loops through the array of cards and checks if the ID of the passed
    // card matches. If so, return its index
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: Remove this, makes no sense
    }
    
    // MARK: - Nested Struct!
    // The Card object. Used by the memory game. Make it identifiable
    struct Card: Identifiable {
        // Properties that define the Card. Content is the emoji. id makes it identifiable
        // Its Generic: when you init the MemoryGame struct (parent), you define it's type
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
