//
//  phoneNumController.swift
//  TaskAnalysis
//
//  Created by Brendan Giberson on 12/1/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import UIKit

class phoneNumController: UIViewController {
    
    var phoneNum:String = ""
    
    
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBAction func submitButton(sender: AnyObject) {
        
        phoneNum = phoneNumTextField.text!
        //check database for phone num if valid pull data
        //if phone valid present next segue and save phone num
        NSUserDefaults.standardUserDefaults().setObject(phoneNum, forKey: "phoneNum")
        //else display error try again
        self.performSegueWithIdentifier("enterApp", sender: self)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().objectForKey("phoneNum") != nil {
            var phoneNum = NSUserDefaults.standardUserDefaults().objectForKey("phoneNum") as! String
            print(phoneNum)
            self.performSegueWithIdentifier("enterApp", sender: self)
            }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) { //close keyboard with click
        
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool { //close keyboard with return
        resignFirstResponder()
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
