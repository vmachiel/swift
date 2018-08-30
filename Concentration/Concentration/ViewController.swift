//
//  ViewController.swift
//  Concentration
//
//  Created by Machiel van Dorst on 04-02-18.
//  Copyright © 2018 vmachiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // The Label that displays the flip count
    @IBOutlet weak var flipCountLabel: UILabel!
    // Arrary of possible emojis. You connectd those with outletArray.
    @IBOutlet var cardButtons: [UIButton]!
    // The link between the controller and model: and instance of the model
    // Lazy init, so it's not really init yet until used: necessay because you use
    // another property, which in swift can only be used if everything has been inited.
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // Number of times you've flipped a card, updates UILabel flipCountLabel when set
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    // Method that's called when a card is touched
    // It takes the index of the button you pressed (cardButtons) and passes it
    // to the model's method chooseCard (using the var game). Update view
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    // Looks at the current state of the cards (model) and updates the view
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]  // View
            let card = game.cards[index]  // Model
            // Match the button with the card
            if card.isFaceUp {
                button.setTitle(emoji, for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
}
























