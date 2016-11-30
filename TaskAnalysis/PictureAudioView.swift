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
    
    var playing:Bool = false
    
    var TaskName:String = ""
    
    @IBOutlet var TabBar: UITabBarItem!
    
    @IBOutlet var stepDescription: UILabel!
    
    @IBOutlet var stepImage: UIImageView!
    
    //player used to play and pause audio
    var player: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var scrubSlider: UISlider!
    
    @IBAction func scrub(sender: AnyObject) {
         player.currentTime = NSTimeInterval(scrubSlider.value)
    }
    @IBOutlet var playButton: UIButton!
    
    @IBAction func playAudioButton(sender: AnyObject) {
        if !playing{
            playing = true
            playButton.setImage(UIImage(named: "pause"), forState: UIControlState.Normal)
            player.play()
            
        }else{
            playing = false
            playButton.setImage(UIImage(named: "playAudio"), forState: UIControlState.Normal)
            player.pause()
        }
        
        
    }
    @IBOutlet var prevStepButton: UIButton!
    
    @IBOutlet var prevStep: UIButton!
    
    @IBOutlet var nextStepButton: UIButton!
    
    @IBAction func nextStep(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stepDescription.text = "Run the plate under hot water water hot under plate run Run the plate under hot water"
        
        do {
            
            //try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test", ofType: "mp3")!))
            try player = AVAudioPlayer(contentsOfURL: NSURL(string: "https://people.cs.clemson.edu/~ggettin/4820/SampleFiles/HeyJude.mp3")!)
            
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
