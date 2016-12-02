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

        
        //Get all of the data on this viewcontroller
        
        
        //Get steps Data
  
        let getStepsData = getStepData()
        getStepsData.downloadItems()
        let getTasksData = getTaskData()
        getTasksData.downloadItems()
        let getLocationDatas = getLocationData()
        getLocationDatas.downloadItems()
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
      
    super.viewDidLoad()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
