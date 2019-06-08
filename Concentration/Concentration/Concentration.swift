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
    // Flipcout: how many cards you've flipped
    var flipCount = 0
    // The cards that are availible (defined in Card file). Inited as empty array.
    // Private set, because a UI needs to see it, but don't set.
    private(set) var cards = [Card]()
    // variable that keeps track of the card that's currently faceup if one is faceup ready to be checked
    // for a match against a newly chosen card. Optional: of none, or two cards are faceup, set to nil
    // Make it a computed property: if get, look at all cards. If only one faceup, return that, else return nil
    //                              if set, pass an index and set the value to that. Turn that card up, all other
    //                              down. Use newValue (also the default local value) for the new value to use
    //                              in the compute.
    // Private implemtation.
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // Go through all cards via index, if faceUp and no other is faceUp, set the index to the var
            // foundIndex. If another is found return nil right away. If only one is found, the foundIndex will
            // have a value: return that. That index will be returned when this property is called for.
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        // Again if a one and only face up index is set, set all the faceUp properties to false EXCEPT the one
        // corresponding to the index.
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)  // true for only the right index, others will be false
            }
        }
    }
    
    // Init for the Concentration class. Make a card with an ID and add two of them to cards array.
    // Do this for the number of pairs you want. This will create two identical cards (same emoji in the
    // view, same identifier here). 
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()   // The unique ID is made here! See Card.swift
            cards.append(card)
            cards.append(card)
            // You do this because Card is a struct, and thus a seperate copy is made (same id).
        }
        flipCount = 0
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
        // Demo assert: check if the index passed is actually one of the indexes of the cards
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index): index not in cards")
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
                // the indexOfOneAndOnlyFaceUpCard DOESN'T need to be set to nil, because every time it is
                // referenced, the property's value is computed based on the current state.
                cards[index].isFaceUp = true
            } else {
                // none or two cards face up so can't match, so set the chosen index as
                // indexOfOneAndOnlyFaceUpCard. The isFaceUp state of all the cards is updated
                // because of the set method of indexOfOneAndOnlyFaceUpCard (computed property) 
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }    
}






















