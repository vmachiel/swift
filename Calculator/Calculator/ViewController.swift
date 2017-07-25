//
//  ViewController.swift
//  Calculator
//
//  Created by Machiel van Dorst on 24-07-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel?
    
    // is the user already typing something?
    // init false: user hasn't typed anything
    var userIsTyping = false
    
    // the @ signifies the connection to the interface builder. Make sure you have the actual button
    // you pressed as one of the arguments typed UIButton.
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        // If you have already typed numbers, add them.
        // if not, set the display to the first digit typed
        // and set userIsTyping to true for the next digits.
        if userIsTyping {
            let textCurrentlyInDisplay = display!.text!
            // you have to unwrap display. But not its text property, since
            // it can be set, and is set. So compiler knows it has a value
            display!.text = textCurrentlyInDisplay + digit
        } else {
            display!.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
    }
    
}

