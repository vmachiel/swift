//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Machiel van Dorst on 25-07-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import Foundation

// What does this model allow PUBLICLY? What does it allow the controller to do?

// No need for inheritance. Will only be refferenced by one Controller. KISAS
struct CalculatorBrain {
    
    // Keeps track of the result as it's calculating. Make private, since 
    // the controller doesn't need to access it. It's not part of the public API. 
    // So you can't Get it either!
    // Make it optional, since it's not set when it's initialized. It doesn't have a value
    // when you start.
    private var accumulator: Double?
    
    
    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "π":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator {
                accumulator = sqrt(operand)
            }
        default:
            break
        }
    }
    
    // Make it mutating, because it's passed by value. It's copy-on-write so swift
    // has to know when to make a copy and thus it has to know when you change it.
    // When and operation is pressed, the model takes the current number and passes
    // it to this function. So it gets put into the accumulator. 
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        
    }
    
    // Is read only: the controller may not change this itself. Only the struct itself may
    // do that. So: make it a computed property with only a get case. NO SET
    // When result is called, return the current accumulator IF it has a value otherwise
    // return nil
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
