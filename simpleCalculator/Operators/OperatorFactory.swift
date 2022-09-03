//
//  _Operation.swift
//  simpleCalculator
//
//  Created by Carlos Reynoso on 2/9/22.
//

struct OperatorFactory {
  
    func getOperator(_ operatorType: OperatorTypes) -> Calculatable {
        
        var _operator: Calculatable
        
        switch operatorType {
        case .Addition:
            _operator = SumOperator()
        case .Substraction:
            _operator = SubstractOperator()
        case .Multiplication:
            _operator = MultiplyOperator()
        case .Division:
            _operator = DivideOperator()
            
        }
        
        
        return _operator
    }
}
