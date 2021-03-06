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

struct Concentration {
    
    // MARK: Properties
    // Flipcout: how many cards you've flipped, and score.
    var flipCount = 0
    var score = 0
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
        // Use a closure to get all the indexes of faceup cards. If there's one, one is faceup
        // and you return that. If not, return nil
        get {
            let faceUpCardIndexes = cards.indices.filter{ cards[$0].isFaceUp }  // trailing closure syntax!
            return faceUpCardIndexes.count == 1 ? faceUpCardIndexes.first : nil
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
    // view, same identifier here). Set flipcount and score to 0, and suffle the cards
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()   // The unique ID is made here! See Card.swift
            cards.append(card)
            cards.append(card)
            // You do this because Card is a struct, and thus a seperate copy is made (same id).
        }
        flipCount = 0
        score = 0
        // Shuffle cards. Take random index using the Int extention
        for _ in 1...100 {
            for index in cards.indices {
                let randomIndex = cards.count.arc4random
                let tempCard = cards[index]
                cards[index] = cards [randomIndex]
                cards[randomIndex] = tempCard
            }
        }
    }
    // MARK: Methods
    // Main public function: the method that gets called when a user picks a card.
    // Three options    1: no cards faceup: just flip the card
    //                  2: two cards face up (matching or not): face them both down and a new one up,
    //                  starting a new match
    //                  3: one card face up: face up the new card and check if they match
    mutating func chooseCard(at index: Int) {
        // Demo assert: check if the index passed is actually one of the indexes of the cards
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index): index not in cards")
        // Only act if card hasn't matched yet.
        if !cards[index].isMatched{
            flipCount += 1
            // Case if there is already one matched, not just one card/chose the same card again
            // (if you did this, it ignores and nothing happens and you need to tap another card)
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // match? set isMatched and update score. (no need to update seenBefore.
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                // not a match? Check if seen before and lower score. Set seen before for both
                } else {
                    if cards[matchIndex].seenBefore || cards[index].seenBefore {
                        score -= 1
                    }
                    cards[matchIndex].seenBefore = true
                    cards[index].seenBefore = true
                }
                // Now the check is done, face up the card you just chose (so the controller can update view)
                // the indexOfOneAndOnlyFaceUpCard DOESN'T need to be set to nil, because every time it is
                // referenced, the property's value is computed based on the current state.
                cards[index].isFaceUp = true
            // none or two cards face up so can't match, so set the chosen index as
            // indexOfOneAndOnlyFaceUpCard. The isFaceUp state of all the cards is updated
            // because of the set method of indexOfOneAndOnlyFaceUpCard (computed property)
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }    
}






















