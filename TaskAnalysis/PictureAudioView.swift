//
//  PictureAudioView.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import AVFoundation

class PictureAudioView: UIViewController, UITabBarDelegate {
    
    var lastStep:Bool = false
    
    var playing:Bool = false
    
    var TaskName:String = ""
    
    @IBOutlet var TabBar: UITabBarItem!
    var taskinfo = ""
    @IBOutlet var stepDescription: UILabel!
    
    @IBOutlet var stepImage: UIImageView!
   
    var image = UIImage()
    
    var audioFile = ""
    
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
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseTimer"), userInfo: nil, repeats: true)
            
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
    
    @IBAction func nextStep(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if last step and if so change arrow to check mark
        //if last step next step func should put check mark over pic
        
        if lastStep == true
        {
            
        }
        
        
        // Do any additional setup after loading the view.
        print(taskinfo)
        stepImage.image = image
        stepDescription.text = "Run the plate under hot water water hot under plate run Run the plate under hot water"
        
        do {
            
            
            let fileURL:NSURL = NSURL(string: "https://people.cs.clemson.edu/~ggettin/4820/SampleFiles/HeyJude.mp3")!
            let soundData = NSData.init(contentsOfURL: fileURL)
            try player = AVAudioPlayer(data: soundData!)
            
            scrubSlider.maximumValue = Float(player.duration)
            
        } catch {
            
            // It didn't work!
            
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateScrubSlider"), userInfo: nil, repeats: true)
        
      
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BacktoSteps"{
            let tabView: UITabBarController = segue.destinationViewController as! UITabBarController
            tabView.selectedIndex = 1
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        player.pause()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
