//
//  AllTasksController.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/29/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit

class AllTasksController: UIViewController {
    
    
    let taskTitles = ["Sweeping", "Laundry", "Fold Napkins", "Clean Dishes", "Cook Pasta"]
    
    //hardcoded task images for now
    let taskImages = [UIImage(named: "sweeping"), UIImage(named: "laundry"), UIImage(named: "foldNapkins"), UIImage(named: "cleanDishes"), UIImage(named: "cookPasta")]
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
