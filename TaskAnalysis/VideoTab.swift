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

class VideoTab: UIViewController {
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    @IBAction func playButton(sender: AnyObject) {
        
        self.presentViewController(playerViewController, animated: true){
            self.playerViewController.player?.play()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let fileURL = NSURL(fileURLWithPath: "/Users/Greg/Documents/School/4820/TaskAnalysis/TaskAnalysis/test.m4v")
        
        playerView = AVPlayer(URL: fileURL)
        
        playerViewController.player = playerView
        

        
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
