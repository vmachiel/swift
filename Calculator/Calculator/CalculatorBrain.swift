//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Machiel van Dorst on 25-07-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import Foundation

// Global file functions for the struct to use:
func changeSign(operand: Double) -> Double {
    return -operand
}

// What does this model allow PUBLICLY? What does it allow the controller to do?
// No need for inheritance. Will only be refferenced by one Controller. KISAS
struct CalculatorBrain {
    
    // Keeps track of the result as it's calculating. Make private, since 
    // the controller doesn't need to access it. It's not part of the public API. 
    // So you can't Get it either!
    // Make it optional, since it's not set when it's initialized. It doesn't have a value
    // when you start.
    private var accumulator: Double?
    
    // Data type to make the dictionary extensible to operations and not just doubles
    // this type is private to the calcbrain struct.
    // Assiate value Double with the constant, and function that takes and returns a double
    // for the operation case:
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
    }
    
    // Table of all operation to make it extensible.
    // Functions are types so can be an associated value (as defined in the enum)
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation(changeSign)
    ]
    
    // If the symbol passed from the viewcontroller matches one in the dict,
    // set the operand to the constant.
    
    // If constant, at it's as. value to constant using let and set the accumulator to it.
    // if Operation: set the as. value to functon. Check if the accumulator has a value,
    // if so, apply operation.
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case.unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)  // Force unwrap, already checked for nil
                }
            }
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
