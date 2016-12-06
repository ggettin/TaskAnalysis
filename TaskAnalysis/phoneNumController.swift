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
        
        if phoneNum.characters.count != 10
        {
            showAlert("Phone number must be 10 digits")
            phoneNumTextField.text = ""
        }
        else{
        //check database for phone num if valid pull data
        //if phone valid present next segue and save phone num
        NSUserDefaults.standardUserDefaults().setObject(phoneNum, forKey: "phoneNum")
        //else display error try again
        //showAlert("Phone number does not exist")
        self.navigationController?.popViewControllerAnimated(false)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem .setHidesBackButton(true, animated: true)
    }

    override func viewDidAppear(animated: Bool) {
        self.navigationItem .setHidesBackButton(true, animated: true)

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
    
    //function for easy resuse of alert boxes
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: { (action) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
}
