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
    
    // Data type to make the dictionary extensible to operations and not just doubles
    // this type is private to the calcbrain struct.
    // Assiate value Double with the constant, and function that takes and returns a double
    // for the operation case:
    // Binary operation: takes two doubles, does the operation and returns a double.
    // equals:
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    // Table of all operation to make it extensible.
    // Functions are types so can be an associated value (as defined in the enum)
    // Use those for unaryOps
    // For binary ops, use closures!
    // No need for types, they are defined in the enum Operation
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "x^2" : Operation.unaryOperation({$0 * $0}),
        "cos" : Operation.unaryOperation(cos),
        "sin" : Operation.unaryOperation(sin),
        "tan" : Operation.unaryOperation(tan),
        "±" : Operation.unaryOperation({ -$0 }),
        "*" : Operation.binaryOperation({ $0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "x^y" : Operation.binaryOperation(pow),
        "=" : Operation.equals
    ]
    
    // If the symbol passed from the viewcontroller matches one in the dict,
    // set the operand to the constant.
    
    // If constant, at it's as. value to constant using let and set the accumulator to it.
    // if Operation: set the as. value to functon. Check if the accumulator has a value,
    // if so, apply operation.
    // If binary op: save the value in new struct until the second operand is there
    // and equals is called. Check if there is a number! And not just someone pressing * or whatever
    // After bin operation, accumulator is set to nil
    // equals calls the performPendingetc function.
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)  // Force unwrap, already checked for nil
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    // When = is pressed, there is a new number in accumulator. Pass it as the second operand
    // to PendingBinaryOperation.perform as stored in the pendingBinOp var. Check if pbo is not nil
    // and that the accumulator has a new typed value.
    // Set result as the current accumulator.
    // clear pendingBinaryOperation
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    // Variable to hold the first operand and function to perform. This is called after user
    // types number and binary operation: number will be in accumulator and operation will be
    // passed to this.
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    // Data structure to hold the first operand and perform the binary operation
    private struct PendingBinaryOperation {
        // These aren't changed, they are used to temp hold value and function:
        let function: (Double, Double) -> Double  // What binary op is being done? (passed by closure)
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
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












