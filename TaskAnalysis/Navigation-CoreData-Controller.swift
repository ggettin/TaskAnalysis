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
        
        let getStepsData = getStepData()
        getStepsData.downloadItems()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
