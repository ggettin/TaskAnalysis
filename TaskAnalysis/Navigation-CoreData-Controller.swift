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

    var loadItems = false
  
    override func viewDidLoad() {
    
        
        
        
        //Get all of the data on this viewcontroller
        
        
        //Get steps Data
        if(loadItems == false){
        let getStepsData = getStepData()
        getStepsData.downloadItems()
        let getTasksData = getTaskData()
        getTasksData.downloadItems()
        }
        super.viewDidLoad()
        loadItems = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
