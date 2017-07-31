//
//  ViewController.swift
//  Calculator
//
//  Created by Machiel van Dorst on 24-07-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit


// ViewController as a label for display, and computed property for its value, that is 
// get and set by the CalCulatorBrain. 
class ViewController: UIViewController {
    
    // The text in the display
    @IBOutlet weak var display: UILabel!
    // The text in the description display
    @IBOutlet weak var descriptionDisplay: UILabel!
    // Has the user typed a number already?
    var userIsInTheMiddleOfTyping = false
    // This property is passed to the brain (the number in the display)
    // This property is set to the result when the brain returns it.
    // Is a Double to be used by brain, set to string to use as display.text
    var displayValue: Double {
        // Assume there's always a valid double
        get { 
            return Double(display.text!)!
        }
        // When you do displayValue = x, newValue is set to x
        set {
            display.text = String(newValue)
        }
    }
    // The whole brain is set to this var to communicate with it.
    private var brain = CalculatorBrain()
    
    // Called when the user touches a button. Properties of the button are in the 
    // sender parameter. You get the number from it's title. 
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        // If you have already typed numbers, add them.
        // if not, set the display to the first digit typed
        // and set userIsTyping to true for the next digits.
        // check for invalid number!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            // you have to unwrap display. But not its text property, since
            // it can be set, and is set. So compiler knows it has a value
            // String cat.
            // Touched digit is not . or there is no . on screen yet:
            if digit != "." || !textCurrentlyInDisplay.contains(".") {
                display.text = textCurrentlyInDisplay + digit
            }
        // and for new numbers: is the digit a ., make screen 0.
        // else, set the digit. 
        // Make userIsInTheMiddleOfTyping bool.
        } else {
            // This could be: {display.text = digit == "." ? "0." : digit
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    // Run when the user touches a operation button, properties are send to the
    // sender parameter. If there is a number typed, send the operand to the brain
    // and reset the bool. Then the button that is pressed is send as the 
    // symbol used to the brain using performOperation method.
    // Finally, the result and descriptions are accessed from the brain, set and 
    // formatted to their displays (display and descriptiondisplay)
    // For des. display, call beautifynumbers, and check if resultIsPending. If it
    // is add ... else add = because it's done. No description? Make it " "
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)  // get is used here
            userIsInTheMiddleOfTyping = false  // IMPORTANT!! This will ensure a new number after an operation. 
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
        }
        if let result = brain.result {
            displayValue = result  // set is used here
        }
        if let description = brain.description {
            descriptionDisplay.text = description.beautifyNumbers() + (brain.resultIsPending ? "..." : "=")
        } else {
            descriptionDisplay.text = " "
        }
    }
}

// Extend string to clean up the numbers for the discprition display
// String will get some beautification code using Regex. Extention is used
// because it might be needed again. 
// Regex takes a pattern and options, can throw error.
// Range is made by counting the caracters in the string the method is done
// on
// Finally, the result is return onto itself (this is a method)
// The pattern (regex constant) is replaced with the provided replacement template. 
// This will be used in cases where the full string needs to be replaced.. i think.
extension String {
    func replace(pattern: String, with replacement: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSMakeRange(0, self.characters.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacement)
    }
}

// The extention that's used by the viewcontroller. It replaces the pattern with the
// substring. So, \\. finds the dot, then none or one or more 0's, then either no number
// at all [^0-9] or the end of the string. So it find .0 or .00 or .0000 etc
// but not .00004 or .000423000243. It replaces that with $1, which is nothing so an
// empty string. So it replaces it with an empty string, effectively deleting it.
extension String {
    func beautifyNumbers() -> String {
        return self.replace(pattern: "\\.0+([^0-9]|$)", with: "$1")
    }
}















