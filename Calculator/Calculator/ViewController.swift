//
//  ViewController.swift
//  Calculator
//
//  Created by Shridhar Sukhani on 18/11/17.
//  Copyright © 2017 Shridhar Sukhani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var useDecimal: Bool = false
    var currentPower: Double = 1
    var brain: CalculatorBrain = CalculatorBrain()
    var userInMiddleOfTyping: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    @IBAction func decimalHit(_ sender: UIButton) {
        if !useDecimal {
            useDecimal = true
            currentPower = 0.1
        }
    }
    
    @IBAction func doOperation(_ sender: UIButton) {
        if userInMiddleOfTyping {
            userInMiddleOfTyping = false
            useDecimal = false
            currentPower = 1
            brain.setOperand(displayValue)
        }
        let operation = sender.currentTitle!
        brain.performOperation(symbol: operation)
        if let result = brain.result {
            displayValue = result
        }
    }
    
    @IBAction func clearDisplay(_ sender: UIButton) {
            displayValue = 0
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if userInMiddleOfTyping {
            if !useDecimal {
                displayValue = displayValue * 10 + Double(sender.currentTitle!)!
            } else {
                displayValue = displayValue + Double(sender.currentTitle!)!*currentPower
                currentPower = currentPower / 10
            }
        } else {
            displayValue = Double(sender.currentTitle!)!
            userInMiddleOfTyping = true
        }
    }
    
}

