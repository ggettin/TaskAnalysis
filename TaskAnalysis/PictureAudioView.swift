//
//  PictureAudioView.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit

class PictureAudioView: UIViewController {

    @IBOutlet var stepDescription: UILabel!
    
    @IBOutlet var stepImage: UIImageView!
    
    @IBAction func playAudioButton(sender: AnyObject) {
    }
    @IBOutlet var prevStepButton: UIButton!
    
    @IBOutlet var prevStep: UIButton!
    
    @IBOutlet var nextStepButton: UIButton!
    
    @IBAction func nextStep(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stepDescription.text = "Run the plate under hot water water hot under plate run Run the plate under hot water water hot under plate run"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
