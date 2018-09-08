//
//  Concentration.swift
//  Concentration
//
//  Created by Machiel van Dorst on 24-03-18.
//  Copyright © 2018 vmachiel. All rights reserved.
//

import Foundation

// The brain of the concentration game. Part of model in MVC. Name the file after the main class
// Think about what your public API should be like: get into the public/private design.
// Three states: none, one, or two cards face up (see methods)

class Concentration {
    
    // MARK: Properties
    // The cards that are availible (defined in Card file). Inited as empty array.
    var cards = [Card]()
    // variable that keeps track of the card that's currently faceup if one is faceup ready to be checked
    // for a match against a newly chosen card. Optional: of none, or two cards are faceup, set to nil
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    // Init for the Concentration class. Make a card with an ID and add two of them to cards array.
    // Do this for the number of pairs you want. This will create two identical cards (same emoji in the
    // view, same identifier here). 
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()   // The unique ID is made here! See Card.swift
            cards.append(card)
            cards.append(card)  // You do this because Card is a struct, and thus a seperate copy is made.
        }
        // TODO: Shuffle cards
    }
    // MARK: Methods
    // Main public function: the method that gets called when a user picks a card.
    // Three options    1: no cards faceup: just flip the card
    //                  2: two cards face up (matching or not): face them both down and a new one up,
    //                  starting a new match
    //                  3: one card face up: face up the new card and check if they match
    // Do nothing if a card has been matched already.
    func chooseCard(at index: Int) {
        if !cards[index].isMatched{
            // Case if there is already one matched, not just one card/chose the same card again
            // (if you did this, it ignores and nothing happens and you need to tap another card)
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if match: if the index of the card up == the one you chose, mark them matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // Now the check is done, face up the card you just chose (so the controller can update view)
                // and set indexOfOneAndOnOnlyFaceUpCard to nil, to set the model set to Not one card chosen
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // no or two cards face up so can't match, set all cards face down.
                // Set the chosen card faceUP, and set indexOfOneAndOnlyFaceUpCard to the chose cards index
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }    
}






















