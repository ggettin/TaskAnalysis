//
//  AllTasksController.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/29/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import CoreData


var allTasksCalled = false

class AllTasksController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet var taskTableView: UITableView!
    @IBOutlet var taskCell: AllTasksCell!
    
    @IBOutlet var cellImage: UIImageView!
    
    
    @IBOutlet var cellLabel: UILabel!
    
    
    
    @IBAction func alltasksbackbutton(sender: AnyObject) {
        
        performSegueWithIdentifier("allid", sender: self)
        allTasksCalled = true
    }
    let taskTitles = ["Sweeping", "Laundry", "Fold Napkins", "Clean Dishes", "Cook Pasta"]
    
    //hardcoded task images for now
    let taskImages = [UIImage(named: "sweeping"), UIImage(named: "laundry"), UIImage(named: "foldNapkins"), UIImage(named: "cleanDishes"), UIImage(named: "cookPasta")]
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection svarion: Int) -> Int {
        
        let context = appDel.managedObjectContext
        let taskRequest = NSFetchRequest(entityName: "TaskTable")
        taskRequest.returnsObjectsAsFaults = false
        do{
            let tasks: [TaskTable] = try context.executeFetchRequest(taskRequest) as! [TaskTable]
            return tasks.count
        }
        catch{
            
        }
        return 0
        
        //return self.taskTitles.count
    }

    
    // creates cell for tasks table
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! AllTasksCell
        
        //cell data is hardcoded for now
        //        cell.stepImage.image = UIImage(named: "cleanDishes")
        //        cell.stepCount.text = "Step " + String(indexPath.row + 1) + ":"
        //        cell.stepDescription.text = "Rinse the dish in hot water the dish in hot water Rinse the dish in hot water"
        
        
        //MARK: CORE DATA
        let context = appDel.managedObjectContext
        let taskRequest = NSFetchRequest(entityName: "TaskTable")
        taskRequest.returnsObjectsAsFaults = false
        taskRequest.sortDescriptors = [NSSortDescriptor(key: "task_id", ascending: true)]
        do{
            let tasks: [AnyObject] = try context.executeFetchRequest(taskRequest)
            //cell.TaskLabel.text = "\(tasks[indexPath.row].valueForKey("task_title")!)" //change to just indexPathrow after fixing the updating and adding

            
            
            //cell.stepImage.image = "\(steps[indexPath.row].step_photo)"
            
//        
//            if(NSURL(string: "\(tasks[indexPath.row].valueForKey("task_image")!)") != nil){
//                
//                let url = NSURL(string: "\(tasks[indexPath.row].valueForKey("task_image")!)")
//                if(NSData(contentsOfURL: url!) != nil){
//                    let data = NSData(contentsOfURL: url!)
//                    cell.TaskImage.image = UIImage(data: data!)
//                }else{
//                    print("Data Nil")
//                }
//            
//            }else{
//                print("Error NIL1111")
//            }
                 //cell.taskVideo = String(tasks[indexPath.row].valueForKey("task_video")!)

            
        }
        catch{
            
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("stepDetails", sender: self)
        self.performSegueWithIdentifier("stepssegues", sender: indexPath)
        
        
        let video = (tableView.cellForRowAtIndexPath(indexPath) as! AllTasksCell).taskVideo
        
        taskVideoss = video
        
        
       /* let vc = storyboard?.instantiateViewControllerWithIdentifier("StepDetail") as! PictureAudioView
        
        let info = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepDescription.text
        vc.taskinfo = info!
        let image = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepImage.image
        
        vc.image = image!
        
        
        vc.audioFile = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepAudio
        print((tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepCount.text)
        print(stepsCount)
        print(indexPath.row)
        if(indexPath.row ==  stepsCount-1){
            
            lastStep = true
            
        }
 */
    }

    
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    

}
