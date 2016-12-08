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
    
    let urlPath: String = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/LocationsTable.php"
    
    
    func downloadItems(){//(input: String, completion: (result: String) -> Void)  {
        
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        task.resume()
       // completion(result: "Complete")
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
        jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments).mutableCopy() as! NSMutableArray
        
    } catch let error as NSError {
        print(error)
        
    }
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = appDel.managedObjectContext
    let locationEntity = NSEntityDescription.entityForName("LocationsTable", inManagedObjectContext: context)
    
    var jsonElement: NSDictionary = NSDictionary()
    let locationData: NSMutableArray = NSMutableArray()
    
    print(jsonResult)
    
    //for(var i = 0; i < jsonResult.count; i++)
    for row in jsonResult
    {
        
        //jsonElement = jsonResult[i] as! NSDictionary
        
        let locationTable = LocationsTable(entity: locationEntity!, insertIntoManagedObjectContext: context)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if let location_id = row["location_id"] as? String,
        let location_name = row["location_name"] as? String,
            let location_photo = row["location_photo"] as? String,
            let location_address = row["location_address"] as? String,
            let delete_id = row["delete_id"] as? String,
            let timestamp = row["timestamp"] as? String
        {
          /*  locationTable.location_id = Int(location_id)
            locationTable.location_name = location_name
            locationTable.location_address = location_address
            locationTable.location_photo = location_photo
            locationTable.delete_id = Int(delete_id)
            locationTable.timestamp = String(timestamp)
          */
            
            if(shouldAddLocation(Int(location_id)!, delete_id: Int(delete_id)!, timestamp: timestamp)){
            
            locationTable.setValue(Int(location_id), forKey: "location_id")
            locationTable.setValue(location_name, forKey: "location_name")
            locationTable.setValue(location_photo, forKey: "location_photo")
            locationTable.setValue(location_address, forKey: "location_address")
            locationTable.setValue(Int(delete_id), forKey: "delete_id")
            locationTable.setValue(timestamp, forKey: "timestamp")
                
            
            
        
        do{
            
            try context.save()
            
        } catch let error as NSError{
            
            print(error)
            
            }
            }
    
        }
        

    }

      //  locationData.addObject(locationTable)
        print(locationData)
    
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        // self.delegate.itemsDownloaded(stepData)
        
    })

}


func shouldAddLocation(id: Int, delete_id: Int, timestamp: String) -> Bool{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "LocationsTable")
    fetchRequest.returnsObjectsAsFaults = false
    
    var newTask = NSPredicate(format: "location_id = %d", id)
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

