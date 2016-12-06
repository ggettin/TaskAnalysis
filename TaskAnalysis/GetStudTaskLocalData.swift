//
//  GetStudTaskLocalData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 12/1/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//
import Foundation
import CoreData
import UIKit


protocol getStudTaskLocalProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getStudTaskLocalData: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: getStudTaskLocalProtocol!
    
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
            parseJSONSTL(data)
        }
        
    }
    
    
}

/*
 func addDataintoCoreData(StepsTable){
 }
 */

func parseJSONSTL(data: NSMutableData) {
    
    var jsonResult: NSMutableArray = NSMutableArray()
    
    do{
        jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        
    } catch let error as NSError {
        print(error)
        
    }
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = appDel.managedObjectContext
    let STLEntity = NSEntityDescription.entityForName("StudentTaskLocalTable", inManagedObjectContext: context)
    
    var jsonElement: NSDictionary = NSDictionary()
    let stlData: NSMutableArray = NSMutableArray()
    
    print(jsonResult)
    
    //for(var i = 0; i < jsonResult.count; i++)
    for row in jsonResult
    {
        
        //jsonElement = jsonResult[i] as! NSDictionary
        
        let STLTable = StudentTaskLocalTable(entity: STLEntity!, insertIntoManagedObjectContext: context)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if  let stl_id = row["stl_id"] as? String,
            let task_id = row["task_id"] as? String,
            let student_id = row["student_id"] as? String,
             let location_id = row["location_id"] as? String
        {
            
            STLTable.setValue(Int(stl_id), forKey: "stl_id")
            STLTable.setValue(Int(task_id), forKey: "task_id")
            STLTable.setValue(Int(location_id), forKey: "student_location_id")
            STLTable.setValue(Int(student_id), forKey: "student_id")

            
        }
        
        do{
            
            try context.save()
            
        } catch let error as NSError{
            
            print(error)
            
        }
        
        stlData.addObject(STLTable)
        print("Saving STL")
        print(stlData)
    }
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        // self.delegate.itemsDownloaded(stepData)
        
    })
}
func shouldAddStudTaskLocal(id: Int, delete_id: Int, timestamp: String) -> Bool{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "TaskTable")
    fetchRequest.returnsObjectsAsFaults = false
    
    var newTask = NSPredicate(format: "task_id = %d", id)
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

