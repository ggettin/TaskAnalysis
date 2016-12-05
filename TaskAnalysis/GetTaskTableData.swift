//
//  GetTaskTableData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 12/1/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//
import Foundation
import CoreData
import UIKit

var tasksCompleted = false
protocol getTaskProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getTaskData: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: getTaskProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/TaskTable.php"
    
    
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
            parseJSONTask(data)
        }
        
    }
    
    
}

/*
 func addDataintoCoreData(StepsTable){
 }
 */

func parseJSONTask(data: NSMutableData) {
    
    var jsonResult: NSMutableArray = NSMutableArray()
    
    do{
        jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        
    } catch let error as NSError {
        print(error)
        
    }
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = appDel.managedObjectContext
    let tasksEntity = NSEntityDescription.entityForName("TaskTable", inManagedObjectContext: context)
    
    var jsonElement: NSDictionary = NSDictionary()
    let taskData: NSMutableArray = NSMutableArray()
    
    print(jsonResult)
    
    //for(var i = 0; i < jsonResult.count; i++)
    for row in jsonResult
    {
        
        //jsonElement = jsonResult[i] as! NSDictionary
        
        let taskTable = TaskTable(entity: tasksEntity!, insertIntoManagedObjectContext: context)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if let task_id = row["task_id"] as? String,
            let task_title = row["task_title"] as? String,
            let task_image = row["task_image"] as? String,
            let task_video = row["task_video"] as? String,
            let location_id = row["location_id"] as? String,
            let delete_id = row["delete_id"] as? String,
            let timestamp = row["timestamp"] as? String
        {
           /*
            taskTable.task_id = Int(task_id)
            taskTable.task_title = task_title
            taskTable.task_video = task_video
            taskTable.delete_id = Int(delete_id)
            taskTable.timestamp = timestamp
            taskTable.location_id = Int(location_id)
            taskTable.task_image = task_image
            taskTable.completed = 0
             */
            
            taskTable.setValue(Int(task_id), forKey: "task_id")
            taskTable.setValue(task_title, forKey: "task_title")
            taskTable.setValue(task_image, forKey: "task_image")
            taskTable.setValue(task_video, forKey: "task_video")
            taskTable.setValue(Int(location_id), forKey: "location_id")
            taskTable.setValue(Int(delete_id), forKey: "delete_id")
            taskTable.setValue(timestamp, forKey: "timestamp")
            taskTable.setValue(0, forKey: "completed")
            
        }
        
        do{
            
            try context.save()
            
        } catch let error as NSError{
            
            print(error)
            
        }
        
        taskData.addObject(taskTable)
        print("Saving Tasks")
        print(taskData)
        tasksCompleted = true
        print("complete")
    }
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        // self.delegate.itemsDownloaded(stepData)
        
    })
}
