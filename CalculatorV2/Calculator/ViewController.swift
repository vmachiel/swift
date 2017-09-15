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
    
    // MARK: - Properties and Outlets
    // The text in the display
    @IBOutlet weak var display: UILabel!
    // The text in the description display
    @IBOutlet weak var descriptionDisplay: UILabel!
    // The text of the memory display
    @IBOutlet weak var memoryDisplay: UILabel!
    
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
    // The dict which can store variables like M (memory) to send to the evaluate method of the calc
    // brain. One it has been updated, use didSet to update the screen. Map all the memory keys (variables),
    // and their values using flatmap to format them, and joined() to make it into one string. Beautify!
    private var variables = Dictionary<String, Double>() {
        didSet {
            memoryDisplay.text = variables.flatMap{$0+": \($1)"}.joined(separator: ", ").beautifyNumbers()
        }
    }

    // MARK: - Buttons 
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
        // And for new numbers: is the digit a ., make screen 0.
        // If it's a 0, and the screen is set to 0, do nothing.
        // If it's a 0, but there is a number from previous calc,
        // fallthrough to default which is:
        // Default: set screen to typed digit. In any case:
        // Make userIsInTheMiddleOfTyping bool.
        } else {
            switch digit {
            case ".":
                display.text = "0."
            case "0":
                if display.text == "0" {
                    return // exit switch
                }
                fallthrough
            default:
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    // Run when the user touches a operation button, properties are send to the
    // sender parameter. If there is a number typed, send the operand to the brain
    // and reset the bool. Then the button that is pressed is send as the 
    // symbol used to the brain using performOperation method.
    // Finally, call the displayResults() method to eval en display resutls. This is 
    // factored out into seperate private function because it's called from different places.
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)  // get is used here
            userIsInTheMiddleOfTyping = false  // IMPORTANT!! This will ensure a new number after an operation. 
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(operation: mathmaticalSymbol)
        }
        calcAndDisplayResult()
    }
    // Reset button. Reset everything by re-initializing the brain. 
    // set display value to 0, set description to empty string and 
    // user typing bool false. Reset the variables
    @IBAction func reset(_ sender: UIButton) {
        brain = CalculatorBrain()
        displayValue = 0
        descriptionDisplay.text = " "
        userIsInTheMiddleOfTyping = false
        variables = Dictionary<String, Double>()
    }
    // Undo button. If user is typing, and the text has something in it,
    // set current text to var. Remove it's last char. If it's now empty,
    // set it to 0 and userIsInTheMiddleOfTyping to false. 
    // Finally, set the display.text to the text var
    // If display is empty, userIsTyping will be false. 
    // In that case: undo. This removes the last Element from the stack.
    // After that, call calcAndDisplayResult to re-eval and update displays again.
    @IBAction func undo(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping, var text = display.text {
            text.remove(at: text.index(before: text.endIndex))
            if text.isEmpty || text == "0" {
                text = "0"
                userIsInTheMiddleOfTyping = false
            }
            display.text = text
        } else {
            brain.undo()
            calcAndDisplayResult()
        }
    }
    // Memory, is currently the only variable supported. A dict is used to more easily add more later. 
    // Add memory to the stack, and start typing new number. calc/update display
    @IBAction func callMemory(_ sender: UIButton) {
        brain.setOperand(variable: "M")
        userIsInTheMiddleOfTyping = false
        calcAndDisplayResult()
    }
    // Set current value to memory, and start typing new number. calc/update display
    @IBAction func storeToMemory(_ sender: UIButton) {
        variables["M"] = displayValue
        userIsInTheMiddleOfTyping = false
        calcAndDisplayResult()
    }
    // MARK: - Update Display
    // Main method to eval result and update display
    // The brain calls its evaluate method to calulate the result. It's passed the variables
    // The result and descriptions are accessed from the evaluation, remember, it returns a tuple,
    // (result, isPending, description)
    // They are set and formatted to their displays (display and descriptiondisplay)
    // For des. display, call beautifynumbers, and check if resultIsPending.
    private func calcAndDisplayResult() {
        let evaluation = brain.evaluate(using: variables)
        
        if let error = evaluation.error {
            display.text = error 
        } else if let result = evaluation.result {
            displayValue = result  // set is used here
        }
        // If description is not empty:
        if evaluation.description != "" {
            descriptionDisplay.text = evaluation.description.beautifyNumbers() + (evaluation.isPending ? "..." : "=")
        } else {
            descriptionDisplay.text = " "
        }
    }
}

// MARK: - Extensions
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















