//
//  Card.swift
//  Concentration
//
//  Created by Machiel van Dorst on 25-03-18.
//  Copyright © 2018 vmachiel. All rights reserved.
//

import Foundation


// Part of model: defines that card.

struct Card {
    
    // MARK: Card vars and constants.
    // Is a card Face up? Is it matched? What's its ID
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    // No image or emoji: it's a model, and it's UI independent
    
    // MARK: Initing a new card with unique ID.
    // The Card type's count of id numbers.
    static var identifierFactory = 0
    // Static function (works on the TYPE Card, not instance, that returns a unique ID)
    // Increments the Card type's unique number and returns it
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1  // No Cards. is needed: you're in a static method so acces static vars
        return identifierFactory
    }
    // Now, structs are inited automatically, but you want to init the ID seperate.
    // Create an init that takes a parameter to init identifier. The rest are auto inited.
    // Use self to distingus. 
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    // MARK: Methods
}





















