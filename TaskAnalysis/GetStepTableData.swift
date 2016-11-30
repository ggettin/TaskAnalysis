//
//  GetStepTableData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/30/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData

protocol getStepProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getStepData: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: getStepProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/StepTable.php"
    
    
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
            self.parseJSON()
        }
        
    }

    
    
    func parseJSON() {
        
        var jsonResult: NSMutableArray = NSMutableArray()
        
        do{
            jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let stepData: NSMutableArray = NSMutableArray()
        
        for(var i = 0; i < jsonResult.count; i++)
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
           let step_data = StepsModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let step_id = jsonElement["step_id"] as? String,
                let step_info = jsonElement["step_info"] as? String,
                let step_photo = jsonElement["step_photo"] as? String,
                let step_audio = jsonElement["step_audio"] as? String,
                let step_number = jsonElement["step_number"] as? String,
                let delete_id = jsonElement["delete_id"] as? String,
                let timestamp = jsonElement["timestamp"] as? String
            {
                step_data.step_id = Int(step_id)
                step_data.step_number = Int(step_number)
                step_data.step_info = step_info
                step_data.step_audio = step_audio
                step_data.step_photo = step_photo
                step_data.delete_id = Int(delete_id)
                step_data.timestamp = timestamp
            }
            
            stepData.addObject(step_data)
            print(stepData)
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
           // self.delegate.itemsDownloaded(stepData)
            
        })
    }
}