//
//  ViewController.swift
//  simpleCalculator
//
//  Created by Carlos Reynoso on 12/7/22.
//

import UIKit

class ViewController: UIViewController {
    var displayingStringValue: String = ""
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numericButtonPressed(_ sender: UIButton) {
        if let buttonValue = sender.titleLabel?.text {
            print(buttonValue)
            displayingStringValue += buttonValue
            textField.text = displayingStringValue
        }
        
    }
    
}

