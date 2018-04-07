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

class Concentration {
    
    // The cards that are availible. Inited as empty array.
    var cards = [Card]()
    
    // Init for the Concentration class. Make a card with an ID and add two of them to cards array.
    // Do this for the number of pairs you want.
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)  // You do this because Card is a struct, and thus a seperate copy is made.
        }
        // TODO: Shuffle cards
    }
    
    // Main public function: the method that gets called when a user picks a card.
    func chooseCard(at index: Int) {
        
    }    
}






















