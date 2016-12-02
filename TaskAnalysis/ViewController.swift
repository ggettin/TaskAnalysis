//
//  ViewController.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/9/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

//User current location
var TaskLocation: String = "test"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate{
    
let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func AllTasksButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ThisController = storyboard.instantiateViewControllerWithIdentifier("AllTasksView") as! AllTasksController
        self.navigationController?.pushViewController(ThisController, animated: true)
        
    }
    @IBAction func logoutButton(sender: AnyObject) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Confirmation", message: "Would you like to logout?", preferredStyle: .Alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            //NSLog("OK Pressed")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("phoneNum")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let phoneController = storyboard.instantiateViewControllerWithIdentifier("login") as! phoneNumController
            self.navigationController?.pushViewController(phoneController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet var locationImage: UIImageView!
    
    //set up way to handle location
    let locationManager = CLLocationManager()
    
    
    //hardcoded tasks for now
    
    var taskTitles = [String]()
    
    //hardcoded task images for now
    //let taskImages = [UIImage(named: "sweeping"), UIImage(named: "foldNapkins"), UIImage(named: "cleanDishes"), UIImage(named: "cookPasta")]
    
    
    
    
    // Determines how many collection view cells there are
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let context = appDele.managedObjectContext
        let taskRequest = NSFetchRequest(entityName: "TaskTable")
        taskRequest.returnsObjectsAsFaults = false
        do{
            let tasks: [TaskTable] = try context.executeFetchRequest(taskRequest) as! [TaskTable]
            return tasks.count
        }
        catch{
            
        }
        return 0

        //return self.taskTitles.count
    }
    
    
    // creates collection view cell for location
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
       /* cell.taskName.text = self.taskTitles[indexPath.row]
        cell.taskImage.image = self.taskImages[indexPath.row]
 */
        
        cell.completionImage.image = UIImage(named: "completed")
        cell.completionImage.hidden = true
        
        //MARK: CORE DATA
        let context = appDele.managedObjectContext
        let taskRequest = NSFetchRequest(entityName: "TaskTable")
        taskRequest.returnsObjectsAsFaults = false
        do{
            let tasks: [AnyObject] = try context.executeFetchRequest(taskRequest)
            cell.taskName.text = "\(tasks[indexPath.row].valueForKey("task_title")!)" //change to just indexPathrow after fixing the updating and adding
            
            
            //cell.stepImage.image = "\(steps[indexPath.row].step_photo)"
            
            //for check marks do not show if cell is not compeleted add var to coredata to represent complete . If complete reset next day
            let completed = tasks[indexPath.row].valueForKey("completed") as! NSNumber
            if (completed == 1)
            {
                cell.completionImage.hidden = false
                
            }
            
            let url = NSURL(string: "\(tasks[indexPath.row].valueForKey("task_image")!)")
            let data = NSData(contentsOfURL: url!)
            cell.taskImage.image = UIImage(data: data!)
            taskTitles.append(cell.taskName.text!)
            
            cell.taskVideo = String(tasks[indexPath.row].valueForKey("task_video")!)
            
        }
        catch{
            
        }
        
        
        return cell
    }
    
    
    //Segues to next view when cell is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        self.performSegueWithIdentifier("showSteps", sender: indexPath)
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("VideoPlayer") as! VideoTab
        
    
        let video = (collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell).taskVideo
        
        vc.taskVideoS = video
       
        
        
        
        
        
        //self.presentViewController(vc, animated: true, completion: nil)
        self.showViewController(vc, sender: self)
        //self.viewDidLoad()
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
        
       //NSUserDefaults.standardUserDefaults().removeObjectForKey("phoneNum")

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
        
        //setup test data will need to link coredata to pass in (LocationLabel, radius, address)
        setupData("Fike", radius: 100, Address: "110 Heisman St, Clemson, SC 29634")
        setupData("Suntrust ATM", radius: 100, Address: "527 Fort Hill St, Clemson, SC 29634")
        setUpLocations()
        

    }

    override func viewDidAppear(animated: Bool) {
        
        if NSUserDefaults.standardUserDefaults().objectForKey("phoneNum") == nil {

           let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let phoneController = storyboard.instantiateViewControllerWithIdentifier("login") as! phoneNumController
            self.navigationController?.pushViewController(phoneController, animated: true)
                        
        }
        
        currentLocation.text = TaskLocation
        
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

    func setUpLocations()
    {
        let context = appDele.managedObjectContext
        let request = NSFetchRequest(entityName: "LocationsTable")
        request.returnsObjectsAsFaults = false
        do{
            
            let results =  try context.executeFetchRequest(request)
            
                for result:AnyObject in results{
                    print(result.valueForKey("location_name"))
                    //print(result.valueForKey("password")!)//get passwords
                    

                }
            
        }catch{
            print("Fetch failed")
        }

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

