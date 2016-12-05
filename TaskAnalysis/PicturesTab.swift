//
//  PicturesTab.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import CoreData

var stepsCount : Int = 0


class PicturesTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var TaskName:String = ""
    
    @IBOutlet var tableView: UITableView!
    
    var steps: [AnyObject] = []


    func tableView(tableView: UITableView, numberOfRowsInSection svarion: Int) -> Int {
        
        do{
            return steps.count
        }catch{
            return 0
        }
        
        
    }
    
    
    // creates cell for steps table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StepCell", forIndexPath: indexPath) as! StepCell
        
        //cell data is hardcoded for now
//        cell.stepImage.image = UIImage(named: "cleanDishes")
//        cell.stepCount.text = "Step " + String(indexPath.row + 1) + ":"
//        cell.stepDescription.text = "Rinse the dish in hot water the dish in hot water Rinse the dish in hot water"
        
        
        //MARK: CORE DATA
        let context = appDel.managedObjectContext
        let stepRequest = NSFetchRequest(entityName: "StepsTable")
        stepRequest.returnsObjectsAsFaults = false
        stepRequest.sortDescriptors = [NSSortDescriptor(key: "step_number", ascending: true)]
        do{
            steps = try context.executeFetchRequest(stepRequest)
            cell.stepCount.text = "\(steps[indexPath.row].valueForKey("step_number")!)" //change to just indexPathrow after fixing the updating and adding
            
            cell.stepDescription.text = "\(steps[indexPath.row].valueForKey("step_info")!)"
         
        
            //cell.stepImage.image = "\(steps[indexPath.row].step_photo)"
            
            let url = NSURL(string: "\(steps[indexPath.row].valueForKey("step_photo")!)")
            let data = NSData(contentsOfURL: url!)
            cell.stepImage.image = UIImage(data: data!)
            
             let audioUrl =  "\(steps[indexPath.row].valueForKey("step_audio")!)"
            cell.stepAudio = audioUrl
            
        }
        catch{
            
        }

        
        
        return cell
    }
    
    //performs segue when a step is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("stepDetails", sender: self)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("StepDetail") as! PictureAudioView
       
        let info = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepDescription.text
        vc.taskinfo = info!
        vc.currentStep = indexPath.row + 1
        vc.steps = steps
        
        let image = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepImage.image
        
        vc.image = image!
    
        
        vc.audioFile = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepAudio
        print((tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepCount.text)
        print(stepsCount)
        print(indexPath.row)
        
        
        
//        self.presentViewController(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    //Passes data to next view during segue. (Not yet used)
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "stepDetails" {
//            
//        }
//    }
//    
    override func viewDidAppear(animated: Bool) {
        self.navigationItem.title = TaskName
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
         let context = appDel.managedObjectContext
         let stepRequest = NSFetchRequest(entityName: "StepsTable")
         stepRequest.returnsObjectsAsFaults = false
         do{
         steps = try context.executeFetchRequest(stepRequest) as! [StepsTable]
         }
         catch{
         }
        
        
        
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
