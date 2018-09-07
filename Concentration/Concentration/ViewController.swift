//
//  ViewController.swift
//  Concentration
//
//  Created by Machiel van Dorst on 04-02-18.
//  Copyright © 2018 vmachiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Outlets and properties
    // The Label that displays the flip count
    @IBOutlet weak var flipCountLabel: UILabel!
    // Arrary of possible emojis. You connectd those with outletArray.
    @IBOutlet var cardButtons: [UIButton]!
    // The link between the controller and model: an instance of the model
    // Lazy init, so it's not really init yet until used: necessay because you use
    // another property to init it, which in swift can only be used if everything has been inited.
    // Use this math to deal with odd number of cards. 
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // Number of times you've flipped a card, updates UILabel flipCountLabel when set
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    // All possible emojis.
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    // MARK: Interface Actions
    // Method that's called when a card is touched
    // It takes the index of the button you pressed (cardButtons) and passes it to the model's
    // to the model's method chooseCard (using the var game). Update view
    // Keep in mind: the index used here is the index of the card in the cardsButtons array. This is
    // NOT the ID of the pair of cards used in Concentration/Card (or is it.. check)
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    // Mark: VC Methods
    // Looks at the current state of the cards (model) and updates the view
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]  // View, index in cardButtons
            let card = game.cards[index]  // Model, index in cards in the Concentration model through game instance
            // Matches the button with the card
            // If card is faceup, call the emojie method to set  and make it with
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            // If card is facedown, make it orang with no title, or transparant if already matched.
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)  // If matched, make it clear so you don't see
                // them anymore.
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        return "?"
    }
}
























