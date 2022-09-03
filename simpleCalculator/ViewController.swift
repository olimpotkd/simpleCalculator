//
//  ViewController.swift
//  simpleCalculator
//
//  Created by Carlos Reynoso on 12/7/22.
//

import UIKit

class ViewController: UIViewController {
    var displayingStringValue: String = "0"
    var operationValue: Double = 0
    var lastOperationValue: Double = 0
    var result: Double = 0
    var shouldClear: Bool = false
    
    @IBOutlet weak var valueDisplay: UILabel!
        
    var queuedOperation: OperatorTypes? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numericButtonPressed(_ sender: UIButton) {
        if shouldClear {
            clearDisplayValue()
        }
        if let buttonValue = sender.titleLabel?.text {
            if buttonValue == "." && displayingStringValue.contains(".") {
                return
            }
            if displayingStringValue == "0" && buttonValue != "." {
                displayingStringValue = buttonValue
            } else {
                displayingStringValue += buttonValue
            }
            valueDisplay.text = displayingStringValue
        }
        operationValue = Double(displayingStringValue) ?? 0
    }
    
    @IBAction func clearDisplayValue() {
        if(displayingStringValue.isEmpty) {
            handleHardClear()
        }
        displayingStringValue = "0"
        valueDisplay.text = displayingStringValue
        operationValue = 0
        shouldClear = false
    }
    
    @IBAction func handleHardClear() {
        displayingStringValue = "0"
        valueDisplay.text = displayingStringValue
        operationValue = 0
        lastOperationValue = 0
        queuedOperation = nil
        result = 0
        shouldClear = false
    }
    
    //This is repeating. Could potentially be encapsulated
    @IBAction func handleMultiplyPress(_ sender: UIButton) {
        if queuedOperation != nil { handleProcess() }

        queuedOperation = OperatorTypes.Multiplication
    }
    @IBAction func handleSumPress(_ sender: UIButton) {
        if queuedOperation != nil { handleProcess() }
        
        queuedOperation = OperatorTypes.Addition
    }
    @IBAction func handleDividePress(_ sender: UIButton) {
        if queuedOperation != nil { handleProcess() }

        queuedOperation = OperatorTypes.Multiplication
    }
    @IBAction func handleSubstractPress(_ sender: UIButton) {
        if queuedOperation != nil { handleProcess() }
        
        queuedOperation = OperatorTypes.Multiplication
    }
    
    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        lastOperationValue = Double(valueDisplay.text ?? "") ?? 0
        shouldClear = true
    }
    
    @IBAction func handleProcess() {
        var result: Double = 0
        var _operator: Calculatable
        
        if let qOperation = queuedOperation {
            let operatorFactory = OperatorFactory()
            _operator = operatorFactory.getOperator(qOperation)
            result = _operator.calculate(lastOperationValue, operationValue)
        }
       
        shouldClear = true
        displayingStringValue = result.description
        valueDisplay.text = removeTrailingZeroes(result)
        lastOperationValue = result
        
    }
        
    func removeTrailingZeroes(_ value: Double) -> String {
        let textValue: String = String(value)
        let splitValues = textValue.split(separator: ".")
        
        if Double(splitValues[1]) ?? 0 > 0 { //decimal part
            return value.description
        } else {
            return splitValues[0].description
        }
    }
    
}

