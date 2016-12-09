//
//  PicturesTab.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import CoreData

var taskId = 0

class PicturesTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var TaskName:String = ""
    var stepsData = [AnyObject]()
    @IBOutlet var tableView: UITableView!
    
    let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
    //var steps: [AnyObject] = []


    func tableView(tableView: UITableView, numberOfRowsInSection svarion: Int) -> Int {
            print(stepsData.count)
            return stepsData.count
    }
    
    
    // creates cell for steps table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //read()
        let cell = tableView.dequeueReusableCellWithIdentifier("StepCell", forIndexPath: indexPath) as! StepCell
        
        //cell data is hardcoded for now
//        cell.stepImage.image = UIImage(named: "cleanDishes")
//        cell.stepCount.text = "Step " + String(indexPath.row + 1) + ":"
//        cell.stepDescription.text = "Rinse the dish in hot water the dish in hot water Rinse the dish in hot water"
        
        
        //MARK: CORE DATA
//        let context = appDel.managedObjectContext
//        let stepRequest = NSFetchRequest(entityName: "StepsTable")
//        stepRequest.returnsObjectsAsFaults = false
//        stepRequest.sortDescriptors = [NSSortDescriptor(key: "step_number", ascending: true)]
//        do{
//            steps = try context.executeFetchRequest(stepRequest)
        
            cell.stepCount.text = "\(stepsData[indexPath.row].valueForKey("step_number")!)" //change to just indexPathrow after fixing the updating and adding
        if("\(stepsData[indexPath.row].valueForKey("step_info")!)" != nil){
            cell.stepDescription.text = "\(stepsData[indexPath.row].valueForKey("step_info")!)"
        } else{
            return cell
        }
        
            //cell.stepImage.image = "\(steps[indexPath.row].step_photo)"
            
            let url = NSURL(string: "\(stepsData[indexPath.row].valueForKey("step_photo")!)")
            let data = NSData(contentsOfURL: url!)
            cell.stepImage.image = UIImage(data: data!)
            
             let audioUrl =  "\(stepsData[indexPath.row].valueForKey("step_audio")!)"
            cell.stepAudio = audioUrl
//            
//        }
//        catch{
//            
//        }

        
        
        return cell
    }
    
    //performs segue when a step is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("stepDetails", sender: self)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("StepDetail") as! PictureAudioView
       
        let info = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepDescription.text
        vc.taskinfo = info!
        
        vc.currentStep = indexPath.row
        vc.steps = stepsData
        
        let image = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepImage.image
        
        vc.image = image!
    
        
        vc.audioFile = (tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepAudio
        print((tableView.cellForRowAtIndexPath(indexPath) as! StepCell).stepCount.text)
        print(indexPath.row)
        
        //self.tableView.reloadData()
        
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
        readSteps()
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
             readSteps()
        super.viewDidLoad()
        print("Viewdidload Pictures tab: Now reading steps:")
   
       // getStepsData.downloadItems()
//         let context = appDel.managedObjectContext
//         let stepRequest = NSFetchRequest(entityName: "StepsTable")
//         stepRequest.returnsObjectsAsFaults = false
//         do{
//         steps = try context.executeFetchRequest(stepRequest) as! [StepsTable]
//         }
//         catch{
//         }
        
        
        
        self.navigationItem.title = TaskName
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    
    func readSteps(){
        userId = NSUserDefaults.standardUserDefaults().objectForKey("userId") as! Int
        var count = 0
        stepsData = [StepsTable]()
        let context = appDele.managedObjectContext
        let userTask = NSFetchRequest(entityName: "TaskStepTable")
        userTask.returnsObjectsAsFaults = false
        //MARK: dontforget to change id
        let userTasks = NSPredicate(format: "task_id = %d", realTaskId)
        userTask.predicate = userTasks
        do{
            let userTaskArray = try context.executeFetchRequest(userTask)
            if(userTaskArray.count > 0){
                for utask in userTaskArray{
                    let taskRequest = NSFetchRequest(entityName: "StepsTable")
                    taskRequest.sortDescriptors = [NSSortDescriptor(key: "step_number", ascending: true)]
                    let specificTasks = NSPredicate(format: "step_id = \(utask.valueForKey("step_id") as! Int)")
                    print("Pictures tab Read call Specific Tasks:")
                    print(specificTasks)
                    
                    taskRequest.returnsObjectsAsFaults = false
                    do{
                        taskRequest.predicate = specificTasks
                        let tasks: [AnyObject] = try context.executeFetchRequest(taskRequest)
                        stepsData.append(tasks[0])
                    
                    }catch{
                    
                }
                    
                }
            }else{
                print("Error NIL")
            }
            
            
            
            //                        taskTitles.append(cell.taskName.text!)
            //                        
            //                        cell.taskVideo = String(tasks[indexPath.row].valueForKey("task_video")!)
            
        }
        catch{
            print("Helko")
        }
        //                }
        //            }
        
        tableView.reloadData()
    }

    
//    func read(){
//        
//        var count = 0
//       stepsData = [StepsTable]()
//        let context = appDele.managedObjectContext
//        let userTask = NSFetchRequest(entityName: "TaskStepTable")
//        userTask.returnsObjectsAsFaults = false
//        //MARK: dontforget to change id
//        let userTasks = NSPredicate(format: "task_id = %d", taskId)
//        userTask.predicate = userTasks
//        do{
//            let userTaskArray = try context.executeFetchRequest(userTask)
//            if(userTaskArray.count > 0){
//                for utask in userTaskArray{
//                    let taskRequest = NSFetchRequest(entityName: "TaskStepsTable")
//                    let specificTasks = NSPredicate(format: "step_id = \(utask.valueForKey("step_id") as! Int)")
//                    taskRequest.returnsObjectsAsFaults = false
//                let userStepArray = try context.executeFetchRequest(taskRequest)
//                    taskRequest.predicate = specificTasks
//                    do{
//                        //for loop
//                        for ustep in userStepArray{
//                            let stepRequest = NSFetchRequest(entityName: "StepsTable")
//                            let specificSteps = NSPredicate(format: "step_id = \(ustep.valueForKey("step_id") as! Int)")
//                            stepRequest.returnsObjectsAsFaults = false
//                        
//                        do{
//                        let steps: [AnyObject] = try context.executeFetchRequest(stepRequest)
//                        stepsData.append(steps[0])
//                        }
//                        
//                    }
//                    }catch{
//                        
//                    }
//                
//                
//                
//                }
//            }else{
//                print("Error NIL")
//            }
//
//            
//        }
//        catch{
//            print("Helko")
//        }
//        tableView.reloadData()
//    }

    

    

}
