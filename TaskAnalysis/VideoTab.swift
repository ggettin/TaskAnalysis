//
//  VideoTab.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

var taskVideoss = ""

class VideoTab: UIViewController {
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    var taskVideoS = "" 
    
    var TaskName:String = ""
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var button: UIButton!
    
    
    
    @IBAction func playButton(sender: AnyObject) {
        
        //presents video player and plays video
        self.presentViewController(playerViewController, animated: true){
            self.playerViewController.player?.play()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("Hello")
        
        //location of video to be played (local for now)
        //let fileURL:NSURL = NSURL(string: "https://people.cs.clemson.edu/~ggettin/4820/SampleFiles/test.m4v")!
        
        let fileURL: NSURL = NSURL(string: taskVideoss)!
        
        
        //creates player
        playerView = AVPlayer(URL: fileURL)
        
        //ads player to the playerViewController
        playerViewController.player = playerView
        
        
        //generates the background thumbnail image
        do {
            let asset = AVURLAsset(URL: fileURL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
            let uiImage = UIImage(CGImage: cgImage)
            imageView.image = uiImage
            
            
            //puts play button back on top
            view.bringSubviewToFront(button)
            
        } catch let error as NSError {
            print("Error generating thumbnail: \(error)")
        }
        
        print(TaskName)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}
