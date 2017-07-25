//
//  ViewController.swift
//  Calculator
//
//  Created by Machiel van Dorst on 24-07-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    // is the user already typing something?
    // init false: user hasn't typed anything
    var userIsTyping = false
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
        if userIsTyping {
            let textCurrentlyInDisplay = display.text!
            // you have to unwrap display. But not its text property, since
            // it can be set, and is set. So compiler knows it has a value
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    // If you can get a operation symbol (if let), check what they are
    // If not in the switch case, do nothing.
    // Users aren't typing a number as soon as you use one of these
    // buttons.
    @IBAction func performOperation(_ sender: UIButton) {
        userIsTyping = false
        if let mathmaticalSymbol = sender.currentTitle {
            switch mathmaticalSymbol {
            case "π":
                displayValue = Double.pi
            case "√":
                displayValue = sqrt(displayValue)
            default:
                break
            }
        }
    }
}











