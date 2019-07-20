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
    // The Label that displays the current score.
    @IBOutlet private weak var scoreLabel: UILabel!
    // The Label that displays the flip count
    @IBOutlet private weak var flipCountLabel: UILabel!
    // Arrary of possible emojis. You connectd those with outletArray.
    @IBOutlet private var cardButtons: [UIButton]!
    // Number of pairs of cards. Computed so it can be reused elsewhere. Read only, so no need for get/set
    // just return the value. 
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    // All possible emojis. Private because you alter it.
    private var emojiChoices = [1: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "💀", "👺", "🧛‍♂️"],
                                2: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"],
                                3: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥅", "🏒"],
                                4: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛"],
                                5: ["🇹🇼", "🇯🇵", "🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇱🇷", "🎌", "🇨🇦", "🇳🇵", "🇬🇪"],
                                6: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑"]
                               ]
    // Themes corresponding with the different emoji choices
    private var themes = [1: (#colorLiteral(red: 1, green: 0.5750408173, blue: 0, alpha: 1),#colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)),
                          2: (#colorLiteral(red: 0.4717273712, green: 0.9074952602, blue: 0.5236093998, alpha: 1),#colorLiteral(red: 0.9104843736, green: 0.8983680606, blue: 0.3937922418, alpha: 1)),
                          3: (#colorLiteral(red: 0.04171297699, green: 0.9893924594, blue: 0.04674313962, alpha: 1),#colorLiteral(red: 1, green: 0, blue: 0.1731372178, alpha: 1)),
                          4: (#colorLiteral(red: 0.9745418429, green: 0.9851904511, blue: 0.949783504, alpha: 1),#colorLiteral(red: 0.04403994232, green: 0.01425747946, blue: 0.04526167363, alpha: 1)),
                          5: (#colorLiteral(red: 0.9922263026, green: 0.008666427806, blue: 0.1016208902, alpha: 1),#colorLiteral(red: 0.05371703953, green: 0.01102141291, blue: 0.9976071715, alpha: 1)),
                          6: (#colorLiteral(red: 0.1961097419, green: 0.9128655791, blue: 0.04837539792, alpha: 1),#colorLiteral(red: 1, green: 0, blue: 0.2067118287, alpha: 1))
                         ]
    // Current emojis in use this game The
    private var currentEmojis = [String]()
    // Current theme in use this game
    private var currentTheme = (#colorLiteral(red: 1, green: 0.5750408173, blue: 0, alpha: 1),#colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1))
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
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    // New game button is pressed. 
    @IBAction func newGame(_ sender: UIButton) {
        setup()
    }
    
    // Mark: VC Methods
    // First setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    // Setup is run every time a new game is started. Even the first one.
    // Set's up the model, updates the view, chooses a theme.
    fileprivate func setup() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emoji.removeAll()
        if let themeNumber = emojiChoices.randomElement()?.key {
            currentEmojis = emojiChoices[themeNumber]!  // If the key exists, the value must too!
            currentTheme = themes[themeNumber]!
        }
        updateViewFromModel()
    }
    
    // Looks at the current state of the cards (model) and updates the view
    // Call everytime a button from the array cardButtons is touched by the user.
    // For each card button in the array, get their view state and model state
    // Check what the model state is, and update the view accordingly
    // !! You use index of cardButtons for the button/view of an object in the view. And
    // you use that index to get a card object stored in the array of the instance of the Constration model
    // (see Concentration.swift). Those will match because of how the model is inited. Each card
    // will have an identifier, equal to one other card) INDEX IS NOT IDENTIFIER!!
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]  // View, index in cardButtons
            let card = game.cards[index]  // Model, index in cards in the Concentration model through game instance
            // So if the model of this particular card is now faceup, set emoji and turn white
            // The emoji method is based on card.identifier, since it is the same for the pair.
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = currentTheme.1
            // If card is facedown, make it orang with no title, or transparant if already matched.
            // matching and done are not implemented yet. 
            } else {
                button.setTitle("", for: UIControl.State.normal)
                // If matched, make it clear so you don't see them anymore.
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme.0
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    // Returns the emoji a particular Card.identifier. It first checks if the card id
    // has an entry in the dict that links Card.identifier with an emoji. If not,
    // it takes a random emoji out of the array, associates it with the Card.identifier and removes
    // it from the array. Uses the extention below.
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, currentEmojis.count > 0 {
            // returns the value it removed
            emoji[card.identifier] = currentEmojis.remove(at: currentEmojis.count.arc4random)
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






















