//
//  calculatorModel.swift
//  sCalc
//
//  Created by mabele leonard on 2/17/17.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import Foundation

func Division(op1:Double,op2:Double)->Double
{
 return op1/op2
}

func Multiplication(op1:Double,op2:Double)->Double
{
    return op1*op2
}
func Addition(op1:Double,op2:Double)->Double
{
    return op1+op2
}
func Subtraction(op1:Double,op2:Double)->Double
{
    return op1-op2
}
class calculatorModel {
    
    private var accumulator=0.0
    private var valueOperand=""
    
    private enum Operation{
        case Constants(Double)
        case UnaryOperations((Double)->Double)
        case BinaryOperations((Double,Double)->Double,(String,String)->String)
        case Result
        case Clear
    }
    
    private struct PendingBinaryOp{
        var binaryFunc:(Double,Double)->Double
        var firstOperand:Double
        var outputFunc: (String, String)->String
        var outputOperand: String
    
    }
    
    private var pending:PendingBinaryOp?
    
    func getOperands(operand:Double){
    
        accumulator=operand
        valueOperand = String(operand)

        
    }


    func executeOp(){
    
        if pending != nil{
            accumulator=pending!.binaryFunc(pending!.firstOperand,accumulator)
            valueOperand=pending!.outputFunc(pending!.outputOperand,valueOperand)
            pending=nil
        }
    }
    
    private var operations:Dictionary<String,Operation>=[
        "∏" : Operation.Constants(M_PI), //M_PI,
        "√" : Operation.UnaryOperations(sqrt),
        "÷" : Operation.BinaryOperations(/,{"("+$0+"/"+$1+")"}),
       // "×" : Operation.BinaryOperations({(op1:Double,op2:Double)->Double
       //     in
       //     return op1*op2
      //      }  //using closure
//),
        "×" :Operation.BinaryOperations(*,{"("+$0+"*"+$1+")"}),//closure
       // "+" : Operation.BinaryOperations(Addition),
        "+" : Operation.BinaryOperations(+,{"("+$0+"+"+$1+")"}),
        "-" : Operation.BinaryOperations(-,{"("+$0+"-"+$1+")"}),
        "Sin" : Operation.UnaryOperations({sin($0)}),
        "Cos" : Operation.UnaryOperations({cos($0)}),
        "Tan" : Operation.UnaryOperations({tan($0)}),
        "℮" : Operation.Constants(M_E),
        "%" : Operation.UnaryOperations({$0/100}),
        "±" : Operation.UnaryOperations({-1*$0}),
        "=" : Operation.Result,
        "C": Operation.Clear
    ]
    
    private func clear(){
     accumulator=0
     pending=nil
    
        //displaying the history of operation
     valueOperand=""
    
    
    }
    func performOperation(symbol:String){
        
        if let opertion = operations[symbol]{
            
            switch opertion {
            case .Constants(let value):
                accumulator = value
            case .UnaryOperations(let function):
                accumulator=function(accumulator)
            case .BinaryOperations(let function, let functionString):
                executeOp()
                pending=PendingBinaryOp(binaryFunc: function, firstOperand: accumulator, outputFunc: functionString, outputOperand: valueOperand)
          
           
              
               
            case .Result:
                executeOp()
                
            case .Clear:
                clear()
           // default:
           //     break
            }
        }
        
       // accumulator=operations[symbol]!
    
       /* switch symbol {
        case "∏":
            accumulator=M_PI
        case "√":
            accumulator=sqrt(accumulator)
        default:
            break
            
        }*/
    
    
    }
    

    var result:Double{
        get{
           // return 0.0
            return accumulator
        }
    }
    
        var sOutput: String{
        get{
        
          return valueOperand
        }
    }
    
}
