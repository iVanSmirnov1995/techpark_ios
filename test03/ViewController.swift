//
//  ViewController.swift
//  test03
//
//  Created by Gennady Evstratov on 06/10/2016.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var display: UILabel!
    
    private var userStartedTyping = false
    
    @IBOutlet weak var pointButton: UIButton!
    
    private let calculator = Calculator()
    
    var displayedNumber: Double {
        get {
            return Double(display.text!) ?? 0.0
        }
        
        set {
            display.text = String(newValue)
            calculator.setNumber(number: newValue)
        }
    }
    
    
    func countCharInString(char:(Character), string:(String) ) -> Int {
        
        var i = 0
        for  c in string.characters {
            
            if c==char {
                i += 1
            }
        }
        return i
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetButtonPressed(_ sender: AnyObject) {
        display.text = "0"
        userStartedTyping = false
        calculator.setNumber(number: displayedNumber)
    }
    
    @IBAction func operationButtonPressed(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        guard let op = button.currentTitle else {
            return
        }
        
        displayedNumber = calculator.performOperation(operation: op)
        userStartedTyping = false
    }
    
    @IBAction func numberButtonPressed(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        
        guard let currentText = display.text, let number = button.currentTitle else {
            return
        }
        
        
        self.pointButton.isUserInteractionEnabled=true
        
        if (countCharInString(char: ".", string: currentText))>0{
            
            self.pointButton.isUserInteractionEnabled=false
        }
 
        
        if userStartedTyping {
            display.text = currentText + number
        } else {
            display.text = number
        }
        
        calculator.setNumber(number: displayedNumber)
        userStartedTyping = true
    }
}

