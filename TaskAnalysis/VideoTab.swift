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
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var button: UIButton!
    @IBAction func playButton(sender: AnyObject) {
        
        self.presentViewController(playerViewController, animated: true){
            self.playerViewController.player?.play()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let fileURL = NSURL(fileURLWithPath: "/Users/Greg/Documents/School/4820/TaskAnalysis/TaskAnalysis/test.m4v")
        
        playerView = AVPlayer(URL: fileURL)
        
        playerViewController.player = playerView
        
        do {
            let asset = AVURLAsset(URL: fileURL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
            let uiImage = UIImage(CGImage: cgImage)
            imageView.image = uiImage
            // lay out this image view, or if it already exists, set its image property to uiImage
            view.bringSubviewToFront(button)
        } catch let error as NSError {
            print("Error generating thumbnail: \(error)")
        }
        
        
        

        
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
