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
    
    // MARK: - Properties
    // A stack to collect all operations and operands and variables. Will keep everything, until you 
    // press undo or clear
    private var stack = [Element]()
    // Public properties that return the result is availible, wether an operation is pending, and
    // a description. All are taken from the return tuple of the evaluate() method. 
    // NOTICE: These are now deprecated as per the assignment inscructions. Searching online tells me
    // I should use @availible
    @available(*, deprecated, message: "Depricated, no longer useable")
    var result: Double? {
        return evaluate().result
    }
    @available(*, deprecated, message: "Depricated, no longer useable")
    var resultIsPending: Bool {
        return evaluate().isPending
    }
    @available(*, deprecated, message: "Depricated, no longer useable")
    var description: String? {
        return evaluate().description
    }

    // MARK: - Basic operation
    // The options for to use in the evalute function, which handles variables ('x') as well.
    // Use asso. values to pass actual values along, define types here.
    private enum Element {
        case operation(String)
        case operand(Double)
        case variable(String)
    }
    // The different kinds of operations the evaluatie method can handle. Defined types in asso. values.
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double, (String) -> String)
        case binaryOperation((Double, Double) -> Double, (String, String) -> String)
        case nullaryOperation(() -> Double, String)
        case equals
    }
    // The different kinds of error messages that can appear, one for unary and one for binary.
    // The two values are passed, and an optional error message is returned.
    private enum Errors {
        case unaryError((Double) -> String?)
        case binaryError((Double, Double) -> String?)
    }

    // Dict built using the Operation enum as values, which are found by string keys passed from VC.
    // Constants can built in functions are used,
    // as well as closures to perform the actual operations and build de description
    // strings.
    // It knows which $ should be of what type because you defined it in the Operation enum.
    // Note to self: In the description case, the new stuff is constantly added to the 
    // existing description!!!
    private let operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        
        "√" : Operation.unaryOperation(sqrt, { "√(" + $0 + ")" }),
        "x²" : Operation.unaryOperation({ pow($0, 2) }, { "(" + $0 + ")²" }),
        "x³" : Operation.unaryOperation({ pow($0, 3) }, { "(" + $0 + ")³" }),
        "eˣ" : Operation.unaryOperation(exp, { "e^(" + $0 + ")" }),
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
        
        "Rnd" : Operation.nullaryOperation({ Double(arc4random()) / Double(UInt32.max) }, "rand()"),
        
        "=" : Operation.equals
    ]
    // Dict built using the Errors enum as values , which are found by string keys passed from VC.
    // For each error, test the conditions under which the error occurs as a closure. If true, set the
    // error message that should return, and nil if not (no error)
    private let errorsInOperation: Dictionary<String, Errors> = [
        "√" : Errors.unaryError({ $0 < 0.0 ? "Root of negative number." : nil }),
        "÷" : Errors.binaryError({$1 == 0.0 ? "Divide by 0" : nil}),
        "1/x" : Errors.unaryError({$0 == 0.0 ? "Divide by 0" : nil}),
        "ln" : Errors.unaryError({ $0 < 0.0 ? "Natural log of negative" : nil }),
        "log" : Errors.unaryError({ $0 < 0.0 ? "10 log of negative" : nil })
    ]

    // MARK: - Variable specific operations: New API in V2
    // Version of set operand with a regular double
    mutating func setOperand(_ operand: Double) {
        stack.append(Element.operand(operand))
    }
    // Version of set operand for dealing with variables as operands. Set add them to the stack
    mutating func setOperand(variable named: String) {
        stack.append(Element.variable(named))
    }
    // Add the operation to be done onto the stack:
    mutating func performOperation(operation symbol: String) {
        stack.append(Element.operation(symbol))
    }
    // Undo, by removing the last Element from stack. VC calls evaluate and update display after this. 
    mutating func undo() {
        if !stack.isEmpty {
            stack.removeLast()
        }
    }

    // MARK: - Evaluate
    // This method will perform the evaluation on the stack of operands, variables and instructions. 
    // A lot of code (accu, pending etc.) has been moved inside this method.
    // It takes a dictionary with all the variable names currently stored, with they values. 
    // If none are stored, dict = nil. It returns a result if it can, weather an operation is pending, 
    // and the description of the calculation, which defaults to an empty string. 
    func evaluate(using variables: Dictionary<String, Double>? = nil) -> (result: Double?, isPending: Bool, description: String, error: String?) {
        
        // First, setup the accumulator and the pending binary operation stuff. 
        // This is moved inside this method because because this method handles variables
        var accumulator: (acc: Double, des: String)?
        // Takes a operation, a description to add to the description string, and a accumulator to
        // set to the first operand. Is nil if nothing pending.
        var pendingBinaryOperation: PendingBinaryOperation?
        // Has the evaluation produced an error?
        var error: String?
        
        struct PendingBinaryOperation {
            // Store the acutal function, the description and the current (operand, description)
            let function: (Double, Double) -> Double  // What binary op is being done? (passed by closure)
            let description: (String, String) -> String
            let firstOperand: (Double, String)
            
            // Called when the second operand is set and equals is passed
            func perform(with secondOperand: (Double, String)) -> (Double, String) {
                return (function(firstOperand.0, secondOperand.0), description(firstOperand.1, secondOperand.1))
            }
        }
        // If it does have data and equals is pressed and there is a new number in the accumulator,
        // call its perform method.
        func performPendingBinaryOperation() {
            if pendingBinaryOperation != nil && accumulator != nil {
                accumulator = pendingBinaryOperation!.perform(with: accumulator!)
                pendingBinaryOperation = nil
            }
        }
        
        // The result and description to be returned at the end, after the code that evals the stack.
        // Check optionals so you only unwrap safely!
        var result: Double? {
            if accumulator != nil {
                return accumulator!.acc
            }
            return nil
        }
        // Check if pending operation, else return accu description, which can be an empty string
        var description: String? {
            if pendingBinaryOperation != nil {
                return pendingBinaryOperation!.description(pendingBinaryOperation!.firstOperand.1, accumulator?.1 ?? "")
            } else {
                return accumulator?.1
            }
        }
        
        // The meat of the method: evaluation. The term stack is misleading here, it's not last in first
        // out, but first in first out. For each element in the stack, check what it is. 
        // Operand? set acc to it. 
        // Operation? Check the dictionary for a match, and switch the value (which is an enum Operation)
        // to perform the appropriate action, same as before. 
        // If it's a variable, look it up in optional dictionary to see if it has a value associated with it
        // If not, display 0
        for element in stack {
            switch element {
            case .operand(let value):
                accumulator = (value, "\(value)")
            case .operation(let symbol):
                if let operation = operations[symbol] {
                    switch operation {
                        // Constant? set it to the accumulator, so the ViewController can
                    // get it back to the display. Save the symbol as well.
                    case .constant(let value):
                        accumulator = (value, symbol)
                    case .unaryOperation(let function, let description):
                        if accumulator != nil {
                            accumulator = (function(accumulator!.acc), description(accumulator!.des))
                            // force! already nil checked
                        }
                    // Again, the ass values of the enum stored in the dict value can be set to constants.
                    case .binaryOperation(let function, let description):
                        performPendingBinaryOperation()
                        if accumulator != nil {
                            pendingBinaryOperation = PendingBinaryOperation(function: function, description: description, firstOperand: accumulator!)
                            accumulator = nil
                        }
                    case .equals:
                        performPendingBinaryOperation()
                    case .nullaryOperation(let function, let description):
                        accumulator = (function(), description)
                    }
                }
            // If the variable has a value: display it. If not, show it as 0
            case .variable(let symbol):
                if let value = variables?[symbol] {
                    accumulator = (value, symbol)
                } else {
                    accumulator = (0, symbol)
                }
            }
        }
        return (result, pendingBinaryOperation != nil, description ?? "", error)
    }
}

























