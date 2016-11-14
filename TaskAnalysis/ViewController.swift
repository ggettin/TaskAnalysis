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
    
    let taskTitles = ["Sweeping", "Laundry", "Fold Napkins", "Clean Dishes", "Cook Pasta"]
    
    let taskImages = [UIImage(named: "sweeping"), UIImage(named: "laundry"), UIImage(named: "foldNapkins"), UIImage(named: "cleanDishes"), UIImage(named: "cookPasta")]
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.taskTitles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        cell.taskName.text = self.taskTitles[indexPath.row]
        cell.taskImage.image = self.taskImages[indexPath.row]
        cell.completionImage.image = UIImage(named: "completed")
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

