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
    // of type CardContend of the type CardConent
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // empty arry of cards
        cards = Array<Card>()
        // Loop that creates the cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
        }
    }
    
    // MARK: - Methods
    // Function that handles when a card is chosen
    func choose(card: Card) {
        print("card chosen")
    }
    
    // MARK: - Nested Struct!
    // The Card object. Used by the memory game.
    struct Card {
        // Properties that define the Card. Content is the emoji.
        // Its Generic: when you init the MemoryGame struct (parent), you define it's type
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
