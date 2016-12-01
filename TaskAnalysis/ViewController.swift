//
//  ViewController.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/9/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import CoreLocation


//User current location
var TaskLocation: String = "test"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate{

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet var locationImage: UIImageView!
    
    //set up way to handle location
    let locationManager = CLLocationManager()
    
    
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
        //currentLocation.text = TaskLocation

        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        
        //puts a mask on the location image
        self.locationImage.layer.cornerRadius = 20.0
        self.locationImage.layer.borderWidth = 10.0
        self.locationImage.layer.borderColor = UIColor.clearColor().CGColor
        self.locationImage.layer.masksToBounds = true;
    
        self.navigationItem.title = "Tasks"
        
        //setup locationManager
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        

    }

    override func viewDidAppear(animated: Bool) {
        //currentLocation.text = TaskLocation
        
        // status is not determined
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // authorizations were denied
        else if CLLocationManager.authorizationStatus() == .Denied {
            showAlert("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            //authorization accepted
        else if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }

    }
    
    //function for easy resuse of alert boxes
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }

    func setupData( Label: String, radius: Double, Address: String ) {
        // check if system can monitor regions
        if CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion.self) {
            
            //region data need to put in its own class to read multiple regions
            let title = Label
            let regionRadius = radius // in meters
            let address = Address // street, city, state zip
            
            //takes in the address of a location and converts it into 2d coordinates (lat/long)
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if let placemarks = placemarks {
                    if placemarks.count != 0 {
                        let coordinates = placemarks.first!.location
                        let coordinate = coordinates?.coordinate
                        
                        //setup region this will read an object with a saved coordinate and name
                        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate!.latitude,
                            longitude: coordinate!.longitude), radius: regionRadius, identifier: title)
                        self.locationManager.startMonitoringForRegion(region)
                        
                    }
                    else {
                        print("System can't track regions")
                    }
                }
            }
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        TaskLocation = region.identifier
        currentLocation.text = TaskLocation
        print(TaskLocation)
        //showAlert("enter \(region.identifier)")
    }
    
    //user exit region this will set the users current task location to null
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        TaskLocation = "none"
        currentLocation.text = TaskLocation
        print(TaskLocation)
        //showAlert("exit \(region.identifier)")
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

