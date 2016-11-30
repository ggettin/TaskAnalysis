//
//  GetStepTableData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/30/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

/*import Foundation


protocol getStepProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class getBookData: NSObject, NSURLSessionDataDelegate {
    
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
        let bookData: NSMutableArray = NSMutableArray()
        
        for(var i = 0; i < jsonResult.count; i++)
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let step_data =
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let book_id = jsonElement["book_id"] as? String,
                let bookName = jsonElement["book_name"] as? String,
                let bookAuthor = jsonElement["book_author"] as? String,
                let bookPrice = jsonElement["book_Price"] as? String
            {
                book_data.book_id = Int(book_id)
                book_data.book_name = bookName
                book_data.author = bookAuthor
                book_data.book_price = bookPrice
            }
            
            bookData.addObject(book_data)
            //print(bookData)
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.delegate.itemsDownloaded(bookData)
            
        })
    }
}
 */