//
//  LoadingView.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 12/2/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//


import UIKit
import CoreData

class LoadingView: UIViewController{

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
        
        
        super.viewDidLoad()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    

    
    
}
