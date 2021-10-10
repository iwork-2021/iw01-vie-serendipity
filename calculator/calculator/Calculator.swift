//
//  Calculator.swift
//  calculator
//
//  Created by nju on 2021/10/10.
//

import UIKit

class Calculator {
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    var operations=[
        "+":Operation.BinaryOp{
            (op1,op2) in
            return op1+op2
        }
        "-":Operation.BinaryOp{
            (op1,op2) in
            return op1-op2
        }
        "*":Operation.BinaryOp{
            (op1,op2) in
            return op1*op2
        }
        "/":Operation.BinaryOp{
            (op1,op2) in
            return op1/op2
        }
        "=":Operation.EqualOp
        "%":Operation.UnaryOp{
            op in
            return op/100.0
        }
        "+/-":Operation.UnaryOp{
            op in
            return -op
        }
        "C":Operation.UnaryOp{
            _ in
            return 0
        }
        "sin":Operation.UnaryOp{
            op in
            return sin(op)
        }
        "cos":Operation.UnaryOp{
            op in
            return cos(op)
        }
        "tan":Operation.UnaryOp{
            op in
            return tan(op)
        }
        "sinh":Operation.UnaryOp{
            op in
            return sinh(op)
        }
        "cosh":Operation.UnaryOp{
            op in
            return cosh(op)
        }
        "tanh":Operation.UnaryOp{
            op in
            return tanh(op)
        }
        "x!":Operation.UnaryOp{
            op in
            return
        }
        "EE":Operation.UnaryOp{
            op in
            return 10^op
        }
        ""
        "e":Operation.Constant
        {
            _ in
            return 2.7
        }
        ""
    ]

    struct Intermediate{
        var firstOp:Double
        var waitingOperation:(Double,Double)->Double
    }
    var pendingOp:Intermediate?=nil
    func performOperation(operation:String,operand:Double)->Double?
    {
        if(let op=operations[operation])
        {
            switch op{
                case .BinaryOp(let function):
                    pendingOp=Intermediate(firstOp:oprand,waitingOperation:function)
                    return nil
                case .Constant(let value):
                    return value
                case .EqualOp:
                    return pendingOp!.waitingOperation(pendingOp!.firstOp,operand)
                case .UnaryOp(let function):
                    return function(operand)
            }
        }
        return nil

    }
}
