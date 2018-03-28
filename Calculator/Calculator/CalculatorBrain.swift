//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Shridhar Sukhani on 23/11/17.
//  Copyright © 2017 Shridhar Sukhani. All rights reserved.
//

import Foundation

struct CalculatorBrain  {
    
    private enum Operation {
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Constant(Double)
        case Equals
    }
    
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func setOperand(_ op: Double) {
        accumulator = op;
    }
    
    private let symbolToOperation : Dictionary<String, Operation> = [
        "➕" : Operation.BinaryOperation({$0 + $1}),
        "±": Operation.UnaryOperation({-$0}),
        "π": Operation.Constant(Double.pi),
        "ℯ": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "➖": Operation.BinaryOperation({$0 - $1}),
        "➗": Operation.BinaryOperation({$0/$1}),
        "✖️": Operation.BinaryOperation({$0 * $1}),
        "^": Operation.BinaryOperation(pow),
        "=": Operation.Equals,
        "sin": Operation.UnaryOperation(sin),
        "cos": Operation.UnaryOperation(cos),
        "tan": Operation.UnaryOperation(tan),
        "arctan": Operation.UnaryOperation(atan),
        "arccos": Operation.UnaryOperation(acos)
    ]
    
    private var pBO: PendingBinaryOperation?
    
    mutating func performOperation(symbol: String) {
        if let operation = symbolToOperation[symbol] {
            switch operation {
            case .Constant(let val):
                accumulator = val
            case .UnaryOperation(let fun):
                if accumulator != nil {
                    accumulator = fun(accumulator!)
                }
            case .BinaryOperation(let fun):
                if accumulator != nil {
                    pBO = PendingBinaryOperation(accumulator: accumulator!, function: fun)
                }
            case .Equals:
                if accumulator != nil && pBO != nil {
                    accumulator = pBO?.performOperation(with: accumulator!)
                }
            }
        }
    }
    
    private struct PendingBinaryOperation {
        var accumulator: Double
        var function: ((Double, Double) -> Double)
        func performOperation(with op2: Double) -> Double {
            return function(accumulator, op2)
        }
    }
    
}
