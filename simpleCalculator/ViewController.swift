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
    
    enum operationType : String {
        case sum = "+"
        case substract = "-"
        case divide = "/"
        case multiply = "*"
        case none = ""
    }
    
    
    var queuedOperation: operationType = operationType.none
    
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
        queuedOperation = operationType.none
        result = 0
        shouldClear = false
    }
    
    @IBAction func handleOperatorButtonPressed(_ sender: UIButton) {
        
        //blink
        if queuedOperation != operationType.none {
            handleProcess()
        }
        if let pressedButton = sender.titleLabel?.text {
            switch pressedButton {
            case "+":
                queuedOperation = operationType.sum
            case "-":
                queuedOperation = operationType.substract
            case "x":
                queuedOperation = operationType.multiply
            case "/":
                queuedOperation = operationType.divide
            default:
                return
            }
        }
        lastOperationValue = Double(valueDisplay.text ?? "") ?? 0
        shouldClear = true
    }
    
    @IBAction func handleProcess() {
        var result: Double = 0
        switch queuedOperation {
        case operationType.sum:
            result = sumValues(lastOperationValue, operationValue)
        case operationType.substract:
            result = substractValues(lastOperationValue, operationValue)
        case operationType.multiply:
            result = multiplyValues(lastOperationValue, operationValue)
        case operationType.divide:
            result = divideValues(lastOperationValue, operationValue)
        default:
            result = 0
        }
        shouldClear = true
        displayingStringValue = result.description
        valueDisplay.text = removeTrailingZeroes(result)
        lastOperationValue = result
        
    }
    
    //    OPERATION FUNCTIONS
    func sumValues(_ a: Double, _ b: Double) -> Double {
        return a + b
    }
    
    func substractValues(_ a: Double, _ b: Double) -> Double {
        return a - b
    }
    
    func multiplyValues(_ a: Double, _ b: Double) -> Double {
        return (a * b).rounded()
    }
    
    func divideValues(_ a: Double, _ b: Double) -> Double {
        return a / b
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
    
    func renderValue(_ value: Double) {
        
    }
}

