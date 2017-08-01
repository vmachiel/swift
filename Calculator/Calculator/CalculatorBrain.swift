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
    
    // This will hold the current number, and the discription of the current operation.
    private var accumulator: (Double, String)?
    // What does each operation look like, and what does eacht discription look like.
    // They discription functions can be used to build the string.
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double, (String) -> String)
        case binaryOperation((Double, Double) -> Double, (String, String) -> String)
        case equals
    }
    
    // Called by the viewController when operation is pressed to set operand. Set the acc to the
    // operand double and string disciption like:
    mutating func setOperand(_ operand: Double) {
        accumulator = (operand, "\(operand)")
    }
    
    // Returns the result to ViewController.
    var result: Double? {
        get {
            if accumulator != nil {
                // Return the actual number, force because checked.
                return accumulator!.0
            }
            return nil
        }
    }
    
    var description: String? {
        get{
            if resultIsPending {
                return pendingBinaryOperation!.description(pendingBinaryOperation!.firstOperand.1, accumulator?.1 ?? "")
            } else {
                return accumulator?.1
            }
        }
    }
    
    // Dict built using the Operation enum. Constants can built in functions are used,
    // as well as closures to perform the actual operations and build de description
    // strings.
    // It knows which $ should be doubles and which should be string because you
    // defined it in the Operation enum.
    // In the description case, the new stuff is constantly added to the existing des-
    // cription!!!
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt, { "√(" + $0 + ")" }),
        "x²" : Operation.unaryOperation({ pow($0, 2) }, { "(" + $0 + ")²" }),
        "x³" : Operation.unaryOperation({ pow($0, 2) }, { "(" + $0 + ")³"}),
        "cos" : Operation.unaryOperation(cos, { "cos(" + $0 + ")" }),
        "sin" : Operation.unaryOperation(sin, { "sin(" + $0 + ")" }),
        "tan" : Operation.unaryOperation(tan, { "tan(" + $0 + ")" }),
        "±" : Operation.unaryOperation({ -$0 }, { "-(" + $0 + ")" }),
        "1/x" : Operation.unaryOperation({ 1/$0 }, { "1/(" + $0 + ")" } ),
        "ln" : Operation.unaryOperation(log2, { "ln(" + $0 + ")" }),
        "log" : Operation.unaryOperation(log10, { "log(" + $0 + ")" }),
        "x" : Operation.binaryOperation({ $0 * $1 }, { $0 + "x" + $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }, { $0 + "÷" + $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }, { $0 + "+" + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }, { $0 + "-" + $1 }),
        "xʸ" : Operation.binaryOperation(pow, { $0 + "^" + $1 }),
        "=" : Operation.equals
    ]
    
    // Gets called when an operator button is pressed. 
    // Checks the operations dict for a key match, and passes the value to
    // operation parameter. Uses its enums ass. value to perform the action and
    // add description to the accumulator.
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            // Constant? set it to the accumulator, so the ViewController can
            // get it back to the display. Save the symbol as well.
            case .constant(let value):
                accumulator = (value, symbol)
            case .unaryOperation(let function, let description):
                if accumulator != nil {
                    accumulator = (function(accumulator!.0), description(accumulator!.1))
                    // force! already nil checked
                }
            // Again, the ass values of the enum stored in the dict can be set to constants.
            case .binaryOperation(let function, let description):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, description: description, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
//                if description != nil {
//                    print(description!)
//                }
                performPendingBinaryOperation()
            }
        }
    }
    
    
    // Takes a operation, a description to add to the description string, and a accumulator to
    // set to the first operand. Is nil if nothing pending.
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        // Store the acutal function, the description and the current (operand, description)
        let function: (Double, Double) -> Double  // What binary op is being done? (passed by closure)
        let description: (String, String) -> String
        let firstOperand: (Double, String)
        
        // Called when the second operand is set and equals is passed
        func perform(with secondOperand: (Double, String)) -> (Double, String) {
            return (function(firstOperand.0, secondOperand.0), description(firstOperand.1, secondOperand.1))
        }
    }
    // Is there a result pending? Checks if the pendingBinaryOperation var has data
    var resultIsPending: Bool {
        get {
            return pendingBinaryOperation != nil
        }
    }
    // If it does have data and equals is pressed and there is a new number in the accumulator,
    // call its perform method.
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
}












