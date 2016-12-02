//
//  GetLocationTable.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 12/1/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol getLocationProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getLocationData: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: getLocationProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/LocationTable.php"
    
    
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
            parseJSONLocal(data)
        }
        
    }
    
    
}

/*
 func addDataintoCoreData(StepsTable){
 }
 */

func parseJSONLocal(data: NSMutableData) {
    
    var jsonResult: NSMutableArray = NSMutableArray()
    
    do{
        jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        
    } catch let error as NSError {
        print(error)
        
    }
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = appDel.managedObjectContext
    let stepsEntity = NSEntityDescription.entityForName("TaskTable", inManagedObjectContext: context)
    
    var jsonElement: NSDictionary = NSDictionary()
    let taskData: NSMutableArray = NSMutableArray()
    
    print(jsonResult)
    
    //for(var i = 0; i < jsonResult.count; i++)
    for row in jsonResult
    {
        
        //jsonElement = jsonResult[i] as! NSDictionary
        
        let locationTable = LocationsTable(entity: stepsEntity!, insertIntoManagedObjectContext: context)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if let location_id = row["task_id"] as? String,
            let location_name = row["task_title"] as? String,
            let location_image = row["task_image"] as? String,
            let location_addresss = row["location_address"] as? String,
            let delete_id = row["delete_id"] as? String,
            let timestamp = row["timestamp"] as? String
        {
            
            locationTable.location_name = location_name
            locationTable.location_address = location_name
            locationTable.location_image = location_image
            locationTable.delete_id = Int(delete_id)
            locationTable.timestamp = timestamp
            locationTable.location_id = Int(location_id)
            
        }
        
        do{
            
            try context.save()
            
        } catch let error as NSError{
            
            print(error)
            
        }
        
        //taskData.addObject(task_data)
        print(taskData)
    }
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        // self.delegate.itemsDownloaded(stepData)
        
    })
}
