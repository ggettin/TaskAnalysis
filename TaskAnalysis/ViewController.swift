//
//  ViewController.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/9/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet var locationImage: UIImageView!
    
    //hardcoded tasks for now
    
    let taskTitles = ["Sweeping", "Fold Napkins", "Clean Dishes", "Cook Pasta"]
    
    //hardcoded task images for now
    let taskImages = [UIImage(named: "sweeping"), UIImage(named: "foldNapkins"), UIImage(named: "cleanDishes"), UIImage(named: "cookPasta")]
    
    
    
    // Determines how many collection view cells there are
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.taskTitles.count
    }
    
    
    // creates collection view cell for location
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        cell.taskName.text = self.taskTitles[indexPath.row]
        cell.taskImage.image = self.taskImages[indexPath.row]
        cell.completionImage.image = UIImage(named: "completed")
        
        return cell
    }
    
    
    //Segues to next view when cell is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        self.performSegueWithIdentifier("showSteps", sender: indexPath)
    }
    
    
    //Passes data to next view during segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        
        if segue.identifier == "showSteps" {
            let tabView: UITabBarController = segue.destinationViewController as! UITabBarController
            
            tabView.navigationItem.title = taskTitles[sender!.row]
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //trying to update the currentLocation text at the bottom of the screen to match location
        currentLocation.text = TaskLocation

        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        
        //puts a mask on the location image
        self.locationImage.layer.cornerRadius = 20.0
        self.locationImage.layer.borderWidth = 10.0
        self.locationImage.layer.borderColor = UIColor.clearColor().CGColor
        self.locationImage.layer.masksToBounds = true;
    
        self.navigationItem.title = "Tasks"
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

