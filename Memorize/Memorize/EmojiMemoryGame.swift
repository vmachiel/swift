//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Machiel van Dorst on 07/07/2020.
//  Copyright © 2020 vmachiel. All rights reserved.
//

import SwiftUI

// This is the ViewModel. It's an implementation of the model for our view, the translation
// You use Emoji's in our View for the Cards, so the model is inited with emojis or String.
// Import SwiftUI because it's Foundation + UI stuff to bind the view and model

// Class because it's a ViewModel, a portal onto the Model from the View's perspective
// Many views can use the ViewModel and thus want to share an instance of it.
// Classes are in the heap, and passed by refference: many Views can look at it when
// they want to.
// !!!!!This class is built for a specific implementation of the model: MemoryGame<String>
// !!!!!So the MemoryGame.Card.content is a Sring

class EmojiMemoryGame {
    
    
    // MARK: - Properties.
    // The model of the MemoryGame. It's private Prevents one view from changing the model
    // when you don't want it.
    
    private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // The cards of the model. Used to let views see the model. You implement it this way
    // so the model can have functionality to present the data in an optiomal way for the View
    // Defined for MemoryGame with String as the MemoryGame.Card.content
    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }
    
    // MARK: - Init method To pass to model init!!!
    // Notice the inline function notation: closure notation
    // Returns a MemoryGame with <String> and uses the init arguments to make it.
    static func createMemoryGame() -> MemoryGame<String> {
        // So take a array of emojies, and for the lenght of the array, return a string with than emoji
        // the model uses that emoji as content, since the game property sets it the String.
        // The model loops until all the emojis are use because it's equal to numbberOfPairsOfCards.
        let emojis: Array<String> = ["🎃", "👻"]
        return MemoryGame<String>(numberOfPairsOfCards: 2) {pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Intents methods
    // To allow certain actions by the users of the View like choose card, you define
    // intents methods. These define certain ways certain views can change the model.
    // Choose method for a string implementation of the model.
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
