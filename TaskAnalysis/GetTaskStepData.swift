//
//  GetTaskStepData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 12/5/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//
import Foundation
import CoreData
import UIKit


protocol getTaskStepProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getTaskStepData: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: getTaskStepProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/Student-Task-Local.php"
    
    
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
            parseJSONST(data)
        }
        
    }
    
    
}

/*
 func addDataintoCoreData(StepsTable){
 }
 */

func parseJSONST(data: NSMutableData) {
    
    var jsonResult: NSMutableArray = NSMutableArray()
    
    do{
        jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        
    } catch let error as NSError {
        print(error)
        
    }
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = appDel.managedObjectContext
    let STTEntity = NSEntityDescription.entityForName("TaskStepTable", inManagedObjectContext: context)
    
    var jsonElement: NSDictionary = NSDictionary()
    let sttData: NSMutableArray = NSMutableArray()
    
    print(jsonResult)
    
    //for(var i = 0; i < jsonResult.count; i++)
    for row in jsonResult
    {
        
        //jsonElement = jsonResult[i] as! NSDictionary
        
        let STTable = TaskStepTable(entity: STTEntity!, insertIntoManagedObjectContext: context)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if  let stl_id = row["stl_id"] as? String,
            let task_id = row["task_id"] as? String
        {
            
            STTable.setValue(Int(stl_id), forKey: "step_id")
            STTable.setValue(Int(task_id), forKey: "task_id")
            
        }
        
        do{
            
            try context.save()
            
        } catch let error as NSError{
            
            print(error)
            
        }
        
        sttData.addObject(STTable)
        print(sttData)
    }
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        // self.delegate.itemsDownloaded(stepData)
        
    })
}



