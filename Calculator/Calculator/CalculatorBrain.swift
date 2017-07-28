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
    
    private var accumulator: Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }

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

    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    

    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        // These aren't changed, they are used to temp hold value and function:
        let function: (Double, Double) -> Double  // What binary op is being done? (passed by closure)
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
 
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }

    var resultIsPending: Bool {
        get {
            return pendingBinaryOperation != nil
        }
    }
    
}












