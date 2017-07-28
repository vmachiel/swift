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
    // is the user already typing something?
    // init false: user hasn't typed anything
    var userIsInTheMiddleOfTyping = false
    // Make a var that tracks what's in the UILabel display, and tracks it 
    // as if it's a Double. 
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
    
    // the @ signifies the connection to the interface builder. Make sure you have the actual button
    // you pressed as one of the arguments typed UIButton.
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
            // This could be: {display.text = digit == "." ? "0." : digit}
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    // set the model to a private var that the view methods can use
    // Initialize it, no arguments because the struct has no un inits vars
    // The accumulator is optional, set to nil
    private var brain = CalculatorBrain()
    
    // This method is changed to make use of the model built in CalculatorBrain.swift
    // First off: if the user is typing ie has typed some numbers before you press
    // an operation button, set that as the operand in the model. After that, user
    // is done typing number
    
    // If you can succesfully extract a math symbol from the title of the button
    // that was pressed, send it to the model using the brain var to let the model
    // handle it.
    
    // The result coming back from the model is an optional double. If that double
    // does return, set it as the display value. So if sqrt is pressed for instance
    // something will return and assigned to the optional. If you press +, no result
    // yet so no diplay update.
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











