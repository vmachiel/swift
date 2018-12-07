//
//  ViewController.swift
//  Concentration
//
//  Created by Machiel van Dorst on 04-02-18.
//  Copyright © 2018 vmachiel. All rights reserved.
//

import UIKit

// KEEP IN MIND: the difference between index in cardButtons/cards in the Concentration model
// and identifier of a Card.
class ViewController: UIViewController {
    // MARK: Outlets and properties
    // All private.
    // The Label that displays the flip count
    @IBOutlet private weak var flipCountLabel: UILabel!
    // Arrary of possible emojis. You connectd those with outletArray.
    @IBOutlet private var cardButtons: [UIButton]!
    // Number of pairs of cards. Computed so it can be reused elsewhere. Read only, so no need for get/set
    // just return the value. 
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    // Number of times you've flipped a card, updates UILabel flipCountLabel when set
    // Private set because people shouldn't set this.
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    // All possible emojis. Private because you alter it.
    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "💀", "👺", "🧛‍♂️"]
    // Dictionaries that hold the match between the IDENTIFIER OF THE CARD, and the emoji
    // identifier can be use because two cards with same ID need to be the samen.
    // private because you alter it. 
    private var emoji = [Int: String]()
    // The link between the controller and model: an instance of the model
    // Lazy init, so it's not really init yet until used: necessay because you use
    // another property to init it, which in swift can only be used if everything has been inited.
    // Use this math to deal with odd number of cards. Private because of the link with number of
    // cards in UI.
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // MARK: Interface Actions
    // Method that's called when a card is touched
    // It takes the index of the button you pressed (cardButtons) and passes it to the model's
    // to the model's method chooseCard (using the var game). Update view
    // Private, only called by UI
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    @IBAction func newGame(_ sender: UIButton) {
    }
    // Mark: VC Methods
    // Looks at the current state of the cards (model) and updates the view
    // Call everytime a button from the array cardButtons is touched by the user.
    // For each card button in the array, get their view state and model state
    // Check what the model state is, and update the view accordingly
    // !! You use index of cardButtons for the button/view of an object in the view. And
    // you use that index to get a card object stored in the array of the instance of the Constration model
    // (see Concentration.swift). Those will match because of how the model is inited. Each card
    // will have an identifier, equal to one other card)
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]  // View, index in cardButtons
            let card = game.cards[index]  // Model, index in cards in the Concentration model through game instance
            // So if the model of this particular card is now faceup, set emoji and turn white
            // The emoji method is based on card.identifier, since it is the same for the pair.
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            // If card is facedown, make it orang with no title, or transparant if already matched.
            // matching and done are not implemented yet. 
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)  // If matched, make it clear so you don't see
                // them anymore.
            }
        }
    }
    // Returns the emoji a particular Card.identifier. It first checks if the card id
    // has an entry in the dict that links Card.identifier with an emoji. If not,
    // it takes a random emoji out of the array, associates it with the Card.identifier and removes
    // it from the array. Uses the extention below.
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // returns the value it removed
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

// Extention to Int that gives a random number between 0 and the value of that Int. Use in emoji function.
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}






















