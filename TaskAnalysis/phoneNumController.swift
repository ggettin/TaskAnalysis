//
//  phoneNumController.swift
//  TaskAnalysis
//
//  Created by Brendan Giberson on 12/1/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var loginData = [AnyObject]()
var phoneUserId = 0
class phoneNumController: UIViewController {
    
    var phoneNum:String = ""
    let appDele = UIApplication.sharedApplication().delegate as! AppDelegate

    
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
            read(phoneNum)
            userId = phoneUserId
            //userId = 7
            //            if(phoneNum == "5555555555"){
//                userId = 5
            NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
//            }else if(phoneNum == "2222222222"){
//                userId = 8
//                 NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
//            }else if(phoneNum == "3333333333"){
//                userId = 7
//                 NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
//            }
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
    
    
    
    func read(phone: String){
       // userId = NSUserDefaults.standardUserDefaults().objectForKey("userId") as! Int
        let context = appDele.managedObjectContext
        let userLogin = NSFetchRequest(entityName: "LoginTable")
        userLogin.returnsObjectsAsFaults = false
        //MARK: dontforget to change id
        let userTasks = NSPredicate(format: "student_phone_number = %@", phone)
        userLogin.predicate = userTasks
        do{
        let results = try context.executeFetchRequest(userLogin)
            for res in results {
                print("USer ID is: %d", res.valueForKey("student_id") as! Int)
                print(res.valueForKey("student_id"))
                phoneUserId = Int(res.valueForKey("student_id") as! Int)
            }
            
        } catch{
            print("HELLLELLPP")
        }
    }
    
    
}
