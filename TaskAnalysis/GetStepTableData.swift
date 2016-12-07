//
//  GetStepTableData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/30/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var stepssCount = 0
var checkArray: NSMutableArray = NSMutableArray()

protocol getStepProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getStepData: NSObject, NSURLSessionDataDelegate {
    
    //properties
    weak var delegate: getStepProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/StepTable.php"
    
    
    func downloadItems(){//(input: String, completion: (result: String) -> Void) {
        
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        task.resume()
        
       //completion(result: "Complete")
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            parseJSON(data)
        }
        
    }
    
    
}

/*
 func addDataintoCoreData(StepsTable){
 }
 */

func parseJSON(data: NSMutableData) {
    
    var jsonResult: NSMutableArray = NSMutableArray()
    
    do{
        
    
        
        let oldJsonResult = try NSUserDefaults.standardUserDefaults().objectForKey("stepData") as! NSMutableArray!
        
        if(oldJsonResult != jsonResult){
            
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDel.managedObjectContext
            let stepsEntity = NSEntityDescription.entityForName("StepsTable", inManagedObjectContext: context)
            jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments).mutableCopy() as! NSMutableArray
            
            NSUserDefaults.standardUserDefaults().setObject(jsonResult, forKey: "stepData")
            
            var jsonElement: NSDictionary = NSDictionary()
            let stepData: NSMutableArray = NSMutableArray()
            
            print(jsonResult)
            
            //for(var i = 0; i < jsonResult.count; i++)
            for row in jsonResult
            {
            //jsonElement = jsonResult[i] as! NSDictionary
            let step_data = StepsModel()
                let stepsTable = StepsTable(entity: stepsEntity!, insertIntoManagedObjectContext: context)
                
                //the following insures none of the JsonElement values are nil through optional binding
                if let step_id = row["step_id"] as? String,
                    let step_info = row["step_info"] as? String,
                    let step_photo = row["step_photo"] as? String,
                    let step_audio = row["step_audio"] as? String,
                    let step_number = row["step_number"] as? String,
                    let delete_id = row["delete_id"] as? String,
                    let timestamp = row["timestamp"] as? String
                {
                    //                step_data.step_id = Int(step_id)
                    //                step_data.step_number = Int(step_number)
                    //                step_data.step_info = step_info
                    //                step_data.step_audio = step_audio
                    //                step_data.step_photo = step_photo
                    //                step_data.delete_id = Int(delete_id)
                    //                step_data.timestamp = timestamp
                    
                  /*  stepsTable.step_id = Int(step_id)
                    stepsTable.step_number = Int(step_number)
                    stepsTable.step_info = step_info
                    stepsTable.delete_id = Int(delete_id)
                    stepsTable.timestamp = timestamp
                    //Add Functionality to download into directory
                    stepsTable.step_audio = step_audio
                    stepsTable.step_photo = step_photo
                    stepssCount = stepssCount + 1
                    stepData.addObject(stepsTable)
                    */
                    if(shouldAddStep(Int(step_id)!, delete_id: Int(delete_id)!, timestamp: timestamp)){
                    stepsTable.setValue(Int(step_id), forKey: "step_id")
                    stepsTable.setValue(step_info, forKey: "step_info")
                    stepsTable.setValue(step_photo, forKey: "step_photo")
                    stepsTable.setValue(step_audio, forKey: "step_audio")
                    stepsTable.setValue(Int(delete_id), forKey: "delete_id")
                    stepsTable.setValue(timestamp, forKey: "timestamp")
                    stepsTable.setValue(Int(step_number), forKey: "step_number")
                    stepssCount = stepssCount + 1
                    stepData.addObject(stepsTable)
             
                }
            do{
                    
                    try context.save()
                    
                } catch let error as NSError{
                    
                    print(error)
                    
                }
            }
        }
            
            print("Saving steps table to CoreData")
            print(stepData)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                // self.delegate.itemsDownloaded(stepData)
                
            })
        }
    } catch let error as NSError {
        print(error)
        
    }
    
}

func shouldAddStep(id: Int, delete_id: Int, timestamp: String) -> Bool{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "StepsTable")
    fetchRequest.returnsObjectsAsFaults = false
    
    var newTask = NSPredicate(format: "step_id = %d", id)
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

