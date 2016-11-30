//
//  Navigation-CoreData-Controller.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/30/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import CoreData

class Navigation_CoreData_Controller: UINavigationController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let urlPath: NSString = "https://people.cs.clemson.edu/~jtmarro/TeamProject/PHPFiles/StepTable.php"
        
        let urlStr : NSString =  urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let url = NSURL(string: urlStr as String)
        
        let request = NSURLRequest(URL: url!)
        
        let connection = NSURLConnection(request: request, delegate: self)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
