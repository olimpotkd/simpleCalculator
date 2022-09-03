//
//  SumOperation.swift
//  simpleCalculator
//
//  Created by Carlos Reynoso on 2/9/22.
//

struct SumOperator: Calculatable {
    func calculate(_ firstValue: Double, _ secondValue: Double) -> Double {
        return firstValue + secondValue
    }
}
