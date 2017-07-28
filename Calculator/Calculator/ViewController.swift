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
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
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
    private var brain = CalculatorBrain()

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
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false  // IMPORTANT!! This will ensure a new number after an operation. 
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
        }
        if let result = brain.result {
            displayValue = result // no ! because if let unwraps the optional. 
        }
    }
}











