//
//  PicturesTab.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit

class PicturesTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var TaskName:String = ""
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    // creates cell for steps table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StepCell", forIndexPath: indexPath) as! StepCell
        
        //cell data is hardcoded for now
        cell.stepImage.image = UIImage(named: "cleanDishes")
        cell.stepCount.text = "Step " + String(indexPath.row + 1) + ":"
        cell.stepDescription.text = "Rinse the dish in hot water the dish in hot water Rinse the dish in hot water"
        
        return cell
    }
    
    //performs segue when a step is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("stepDetails", sender: self)
    }
    
    //Passes data to next view during segue. (Not yet used)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stepDetails" {
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationItem.title = TaskName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = TaskName
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
