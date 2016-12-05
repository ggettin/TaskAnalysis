//
//  PictureAudioView.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData




class PictureAudioView: UIViewController, UITabBarDelegate {
    
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var lastStep:Bool = false
    
    var firstStep:Bool = false
    
    var playing:Bool = false
    
    var TaskName:String = ""
    
    var currentStep : Int = -1
    
    @IBOutlet var TabBar: UITabBarItem!
    var taskinfo = ""
    @IBOutlet var stepDescription: UILabel!
    
    @IBOutlet var stepImage: UIImageView!
   
    var image = UIImage()
    
    var audioFile = ""
    
    var steps: [AnyObject] = []

    
    //used to update audio time elapsed
    @IBOutlet weak var timerStart: UILabel!
    
    //used to update audio time remaning
    @IBOutlet weak var timerEnd: UILabel!
    
    var timer = NSTimer()
    
    

    //function updates the timer labels in a formatted pattern
    func increaseTimer(){
        var currentTime: NSTimeInterval = player.currentTime
        var endTime: NSTimeInterval = player.duration - currentTime
        
        //save the times formatted min:sec
        let minutes = UInt8(currentTime / 60)
        let seconds = UInt8(currentTime % 60)
        let endMin = UInt8(endTime / 60)
        let endSec = UInt8(endTime % 60)
        
        let strMin = String(format: "%2d", minutes)
        let strSec = String(format: "%.2d", seconds)
        let strEndMin = String(format: "%2d", endMin)
        let strEndSec = String(format: "%.2d", endSec)

        //update labels
        timerStart.text = "\(strMin):\(strSec)"
        timerEnd.text = "\(strEndMin):\(strEndSec)"

    }
    
    //player used to play and pause audio
    var player: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var scrubSlider: UISlider!
    
    @IBAction func scrub(sender: AnyObject) {
         player.currentTime = NSTimeInterval(scrubSlider.value)
         increaseTimer()
    }
    @IBOutlet var playButton: UIButton!
    
    @IBAction func playAudioButton(sender: AnyObject) {
        if !playing{
            playing = true
            playButton.setImage(UIImage(named: "pause"), forState: UIControlState.Normal)
            player.play()
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(PictureAudioView.increaseTimer), userInfo: nil, repeats: true)
            
        }else{
            playing = false
            playButton.setImage(UIImage(named: "playAudio"), forState: UIControlState.Normal)
            player.pause()
            timer.invalidate()
        }
        
        
    }
    @IBOutlet var prevStepButton: UIButton!
    
    @IBOutlet var prevStep: UIButton!
    
    @IBOutlet var nextStepButton: UIButton!
  
    @IBAction func previousStep(sender: AnyObject) {
        if (firstStep != true){
            stepDescription.text = steps[currentStep - 1].valueForKey("step_info")! as! String
            let url = NSURL(string: "\(steps[currentStep - 1].valueForKey("step_photo")!)")
            
            let data = NSData(contentsOfURL: url!)
            stepImage.image = UIImage(data: data!)!
            
            audioFile = "\(steps[currentStep - 1].valueForKey("step_audio")!)"
            
            loadPlayer()
            
            currentStep = currentStep - 1
            
            if currentStep == 1{
                firstStep = true
                prevStepButton.hidden = true
            }else{
                prevStepButton.hidden = false
            }
            
            if currentStep == steps.count{
                lastStep = true
                nextStepButton.setImage(UIImage(named: "completed"), forState: UIControlState.Normal)
            }

            
        }
        
        
        
       
//        if (firstStep != true)
//        {
//            let vc = storyboard?.instantiateViewControllerWithIdentifier("StepDetail") as! PictureAudioView
//            
//            
//            let info = steps[currentStep - 1].valueForKey("step_info")!
//            vc.taskinfo = info as! String
//            vc.steps = steps
//            
//            let url = NSURL(string: "\(steps[currentStep - 1].valueForKey("step_photo")!)")
//            
//            let data = NSData(contentsOfURL: url!)
//            vc.image = UIImage(data: data!)!
//            
//            
//            
//            let audioUrl =  "\(steps[currentStep - 1].valueForKey("step_audio")!)"
//            
//            vc.audioFile = audioUrl
//            
//            if (currentStep == 1) {
//                
//                vc.firstStep = true
//            }
//            
//            currentStep = currentStep - 1
//            
//            navigationController?.pushViewController(vc, animated: true)
//
//            
//        }

    }
    
    
    @IBAction func nextStep(sender: AnyObject) {
        //checkmark should present tasks and place a check mark if completed.
        //call view did load of next cell
        
        
        if !lastStep {
            stepDescription.text = steps[currentStep + 1].valueForKey("step_info")! as! String
            let url = NSURL(string: "\(steps[currentStep + 1].valueForKey("step_photo")!)")
            
            let data = NSData(contentsOfURL: url!)
            stepImage.image = UIImage(data: data!)!
            
            audioFile = "\(steps[currentStep + 1].valueForKey("step_audio")!)"
            
            loadPlayer()
            
            currentStep = currentStep + 1
            
            if currentStep == 1{
                firstStep = true
            }else{
                prevStepButton.hidden = false
            }
            
            
            if currentStep == steps.count{
                lastStep = true
            }

        }else{
            self.performSegueWithIdentifier("BacktoStepsPlease", sender: self)
        }
        
        
        
        
        
        
        
        
        
//        if (lastStep != true)
//        {
//            let vc = storyboard?.instantiateViewControllerWithIdentifier("StepDetail") as! PictureAudioView
//            
//            
//            let info = steps[currentStep + 1].valueForKey("step_info")!
//            vc.taskinfo = info as! String
//            vc.steps = steps
//            
//            let url = NSURL(string: "\(steps[currentStep + 1].valueForKey("step_photo")!)")
//            
//            let data = NSData(contentsOfURL: url!)
//            vc.image = UIImage(data: data!)!
//            
//            
//            
//            let audioUrl =  "\(steps[currentStep + 1].valueForKey("step_audio")!)"
//            
//            vc.audioFile = audioUrl
//            print("HERE \n\n\n\n\n\n\n")
//            print(currentStep+1)
//            print(stepsCount-1)
//            print("\n\n\n\n\n\n\n\n")
//            if (currentStep + 1 ==  stepsCount-1) {
//                
//                vc.lastStep = true
//            }
//            
//            currentStep = currentStep + 1
//            
//            navigationController?.pushViewController(vc, animated: true)
//            
//            
//        }
//        else{
//            let context = appDel.managedObjectContext
//            let taskRequest = NSFetchRequest(entityName: "TaskStepTable")
//            let stepID = steps[currentStep].valueForKey("step_id")!
//            var taskID: AnyObject = "-1" as AnyObject
//            
//            
//            
//            self.performSegueWithIdentifier("BacktoStepsPlease", sender: self)
//            
//            
//            
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if last step and if so change arrow to check mark
        
        let context = appDel.managedObjectContext
        let stepRequest = NSFetchRequest(entityName: "StepsTable")
        stepRequest.returnsObjectsAsFaults = false
        do{
            steps = try context.executeFetchRequest(stepRequest) as! [StepsTable]
        }catch{
            print(error)
        }
        
        
        if currentStep == 1{
            firstStep = true
            prevStepButton.hidden = true
        }
        
        
        if currentStep == steps.count{
            lastStep = true
        }
        
        
        if (firstStep == true)
        {
            prevStepButton.hidden = true
            
    
        }
        
        if lastStep == true
        {
            nextStepButton.setImage(UIImage(named: "completed"), forState: UIControlState.Normal)
            
        }
        
        
        // Do any additional setup after loading the view.
        print(taskinfo)
        stepImage.image = image
        stepDescription.text = "Run the plate under hot water water hot under plate run Run the plate under hot water"
        
        
      
    }
    
    
    func loadPlayer(){
        do {
            let fileURL:NSURL = NSURL(string: audioFile)!
            let soundData = NSData.init(contentsOfURL: fileURL)
            try player = AVAudioPlayer(data: soundData!)
            
            scrubSlider.maximumValue = Float(player.duration)
            
        } catch {
            
            // It didn't work!
            
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(PictureAudioView.updateScrubSlider), userInfo: nil, repeats: true)

    }
    
    override func viewDidAppear(animated: Bool) {
        if (firstStep == true)
        {
            prevStepButton.hidden = true
        }
    }

    func updateScrubSlider() {
        
        scrubSlider.value = Float(player.currentTime)
        
        
    }
    
    @IBOutlet var VideoTabButton: UITabBarItem!
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item == VideoTabButton{
            self.performSegueWithIdentifier("BacktoSteps", sender: self)
        }
    }
    
    func navBar(navBar: UINavigationBar, didSelectItem item: UIBarButtonItem){
        if item == navigationItem.backBarButtonItem{
            self.performSegueWithIdentifier("StepsSegue", sender: self)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BacktoSteps"{
            let tabView: UITabBarController = segue.destinationViewController as! UITabBarController
            tabView.selectedIndex = 1
        }
        if segue.identifier == "StepsSegue" {
            let tabView: UITabBarController = segue.destinationViewController as! UITabBarController
            tabView.selectedIndex = 1
            
        }
        
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        if playing{
            playing = false
            playButton.setImage(UIImage(named: "playAudio"), forState: UIControlState.Normal)
            player.pause()
            timer.invalidate()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
