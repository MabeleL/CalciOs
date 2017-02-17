//
//  ViewController.swift
//  sCalc
//
//  Created by mabele leonard on 2/17/17.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblDisplay: UILabel!
    
    @IBOutlet weak var lblOutput: UILabel!
    
    
    var isUserTyping :Bool=false
    
    var model:calculatorModel=calculatorModel()
    
    var displayValue:Double{
        get{
            return Double(lblDisplay.text!)!
        }
        set{
            lblDisplay.text=String(newValue)
        }
    
    }
    
    
   
    
    
    
    @IBAction func digitTouched(sender: UIButton) {

  
        let digit = sender.currentTitle!
        
        if (isUserTyping == true) {
            let decimalDisplay = lblDisplay.text!
                lblDisplay.text = (digit == "." && decimalDisplay.rangeOfString(".") !=
                    nil) ? decimalDisplay : decimalDisplay + digit
        }else{
            lblDisplay.text = (digit == ".") ? "0." : digit
            
        }
        
    
          isUserTyping=true
    }
    

    
    @IBAction func performedOperation(sender: AnyObject) {
    
    
    if isUserTyping {
        model.getOperands(displayValue)
       isUserTyping=false
     }
    
        if let matsymbol=sender.currentTitle! {
            model.performOperation(matsymbol)
        }
        
        displayValue=model.result
        
        if(sender.currentTitle!! == "="){
         lblOutput.text = model.sOutput + sender.currentTitle!!
        } else{
            lblOutput.text = model.sOutput
        }
    
        
    
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

