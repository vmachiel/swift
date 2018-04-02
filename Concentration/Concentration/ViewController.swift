//
//  ViewController.swift
//  Concentration
//
//  Created by Machiel van Dorst on 04-02-18.
//  Copyright © 2018 vmachiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // The link between the controller and model: and instance of the model
    var game = Concentration()
    
    // The Label that displays the flip count
    @IBOutlet weak var flipCountLabel: UILabel!
    // Arrary of possible emojis. You connectd those with outletArray.
    @IBOutlet var cardButtons: [UIButton]!
    
    // Number of times you've flipped a card, updates UILabel flipCountLabel when set
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    // Method that's called when a card is touched
    // It takes the index of the button you pressed (cardButtons) and passes
    // the corresponding emoji to flipCard
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
    }
    // Method that flips a card over.
    // Check if the button is an emoji, if so flip to orange
    // If orange, flip to its emoji.
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
}























