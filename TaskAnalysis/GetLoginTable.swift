//
//  GetLoginTable.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 12/8/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol getLoginProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getLoginTable: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: getTaskStepProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/LoginTable.php"
    
    
    func downloadItems() {
        
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        task.resume()
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            parseJSONUser(data)
        }
        
    }
    
    
}

/*
 func addDataintoCoreData(StepsTable){
 }
 */

func parseJSONUser(data: NSMutableData) {
    
    var jsonResult: NSMutableArray = NSMutableArray()
    
    do{
        jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        
    } catch let error as NSError {
        print(error)
        
    }
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = appDel.managedObjectContext
    let STTEntity = NSEntityDescription.entityForName("LoginTable", inManagedObjectContext: context)
    
    var jsonElement: NSDictionary = NSDictionary()
    let loginsData: NSMutableArray = NSMutableArray()
    
    print(jsonResult)
    
    //for(var i = 0; i < jsonResult.count; i++)
    for row in jsonResult
    {
        
        //jsonElement = jsonResult[i] as! NSDictionary
        
        let LogTable = LoginTable(entity: STTEntity!, insertIntoManagedObjectContext: context)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if   let delete_id = row["delete_id"] as? String,
            let student_id = row["student_id"] as? String,
            let student_name = row["student_name"] as? String,
            let student_phone_number = row["student_phone_number"] as? String,
            let timestamp = row["timestamp"] as? String
        {
            if(shouldAddLogin(Int(student_id)!)){
                LogTable.setValue(Int(student_id), forKey: "student_id")
                LogTable.setValue(String(student_name), forKey: "student_name")
                LogTable.setValue(String(student_phone_number), forKey: "student_phone_number")
                  LogTable.setValue(Int(delete_id), forKey: "delete_id")
                  LogTable.setValue(String(timestamp), forKey: "timestamp")
                
                do{
                    
                    try context.save()
                    
                } catch let error as NSError{
                    
                    print(error)
                    
                }
            }
        }
        
        loginsData.addObject(LogTable)
        print(loginsData)
    }
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        // self.delegate.itemsDownloaded(stepData)
        
    })
}

func shouldAddLogin(id: Int) -> Bool{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "LoginTable")
    fetchRequest.returnsObjectsAsFaults = false
    
    var newTask = NSPredicate(format: "student_id = %d", id)
    fetchRequest.predicate = newTask
    
    do{
        var newTasks = try managedContext.executeFetchRequest(fetchRequest) as! [AnyObject]
        if(newTasks.count == 0){
            return true
        }
    }catch{
        print("Could not Update Core Data")
    }
    return false
    
}



