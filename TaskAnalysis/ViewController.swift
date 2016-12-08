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

let getStepsData = getStepData()
let getTasksData =  getTaskData()
let getLocationDatas = getLocationData()
let getTaskStepsData = getTaskStepData()
let getStudentTaskLocationData = getStudTaskLocalData()

var userId = 0
var realTaskId = 0

var viewcontrollerloadedalready = false
//User current location
var TaskLocation: String = "All"
var taskText: String = "All"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate{
    
//dictionary for locationname/url
var urlDictionary = [String: NSURL]()
var tasksData = [AnyObject]()

//dictionary for locationname/locationID
var idDictionary = [String: String]()
    
let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {89}

    
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
             NSUserDefaults.standardUserDefaults().removeObjectForKey("userId")
            
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
    
    //var taskTitles = [String]()
    
    //hardcoded task images for now
    //let taskImages = [UIImage(named: "sweeping"), UIImage(named: "foldNapkins"), UIImage(named: "cleanDishes"), UIImage(named: "cookPasta")]
    
    
    
    
    // Determines how many collection view cells there are
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        let context = appDele.managedObjectContext
//        let taskRequest = NSFetchRequest(entityName: "TaskTable")
//        taskRequest.returnsObjectsAsFaults = false
//        do{
//            let tasks: [TaskTable] = try context.executeFetchRequest(taskRequest) as! [TaskTable]
//            return tasks.count
//        }
//        catch{
//            print("CollectionView Error")
//        }
        print(tasksData.count)
        return tasksData.count

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
        
        cell.taskName.text = "\(tasksData[indexPath.row].valueForKey("task_title")!)"
        if(NSURL(string: "\(tasksData[indexPath.row].valueForKey("task_image")!)") != nil){
            
    let url = NSURL(string: "\(tasksData[indexPath.row].valueForKey("task_image")!)")
                            if(NSData(contentsOfURL: url!) != nil){
                                let data = NSData(contentsOfURL: url!)
                                cell.taskImage.image = UIImage(data: data!)
                            }else{
                                print("Data Nil")
                            }
            
                        }else{
                            print("Error NIL")
                        }
        
                    cell.taskVideo = String(tasksData[indexPath.row].valueForKey("task_video")!)
        
        cell.taskIdentifier = Int("\(tasksData[indexPath.row].valueForKey("task_id")!)")!
        
        //MARK: CORE DATA
       // let context = appDele.managedObjectContext
//        let taskRequest = NSFetchRequest(entityName: "TaskTable")
//        let specificTasks = NSPredicate(format: "task_id = %d", 1)
//        taskRequest.returnsObjectsAsFaults = false
//        do{
//            taskRequest.predicate = specificTasks
//            let tasks: [AnyObject] = try context.executeFetchRequest(taskRequest)
//            cell.taskName.text = "\(tasks[indexPath.row].valueForKey("task_title")!)" //change to just indexPathrow after fixing the updating and adding
//            
//            
//            //cell.stepImage.image = "\(steps[indexPath.row].step_photo)"
//            
//            //for check marks do not show if cell is not compeleted add var to coredata to represent complete . If complete reset next day
//            let completed = tasks[indexPath.row].valueForKey("completed") as! NSNumber
//            
//            if (completed == 1)
//            {
//                cell.completionImage.hidden = false
//                
//            }
//            
//            if(NSURL(string: "\(tasks[indexPath.row].valueForKey("task_image")!)") != nil){
//                
//                let url = NSURL(string: "\(tasks[indexPath.row].valueForKey("task_image")!)")
//                if(NSData(contentsOfURL: url!) != nil){
//                    let data = NSData(contentsOfURL: url!)
//                    cell.taskImage.image = UIImage(data: data!)
//                }else{
//                    print("Data Nil")
//                }
//                
//            }else{
//                print("Error NIL")
//            }
//            
//            
//            
//            taskTitles.append(cell.taskName.text!)
//            
//            cell.taskVideo = String(tasks[indexPath.row].valueForKey("task_video")!)
//            
//        }
//        catch{
//            print("Helko")
//        }
//        
//        
        return cell
            
    }
    
    func read(){
          userId = NSUserDefaults.standardUserDefaults().objectForKey("userId") as! Int
        var count = 0
        tasksData = [TaskTable]()
        let context = appDele.managedObjectContext
        let userTask = NSFetchRequest(entityName: "StudentTaskLocalTable")
        userTask.returnsObjectsAsFaults = false
        //MARK: dontforget to change id
        let userTasks = NSPredicate(format: "student_id = %d", userId)
        userTask.predicate = userTasks
        do{
            let userTaskArray = try context.executeFetchRequest(userTask)
            if(userTaskArray.count > 0){
                for utask in userTaskArray{
                    let taskRequest = NSFetchRequest(entityName: "TaskTable")
                    let specificTasks = NSPredicate(format: "task_id = \(utask.valueForKey("task_id") as! Int)")
                    taskRequest.returnsObjectsAsFaults = false
                    do{
                       
                        if TaskLocation != "All"
                        {
                            let location = Int(TaskLocation)
                            let locationTasks = NSPredicate(format: "location_id", location!)
                            
                            let compoundPredicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: [specificTasks, locationTasks])
                        
                            taskRequest.predicate = compoundPredicate
                            
                        }
                            
                        else
                        {
                            taskRequest.predicate = specificTasks

                        }
                        
                        let tasks: [AnyObject] = try context.executeFetchRequest(taskRequest)
                        tasksData.append(tasks[0])
                        
                     
                        //count+=1
                        
                        
//                        cell.taskName.text = "\(tasks[count].valueForKey("task_title")!)" //change to just indexPathrow after fixing the updating and adding
                        
                        
                        //cell.stepImage.image = "\(steps[indexPath.row].step_photo)"
                        
//                        //for check marks do not show if cell is not compeleted add var to coredata to represent complete . If complete reset next day
//                        let completed = tasks[indexPath.row].valueForKey("completed") as! NSNumber
//                        
//                        if (completed == 1)
//                        {
//                            cell.completionImage.hidden = false
//                            
//                        }
//                        
//                        if(NSURL(string: "\(tasks[indexPath.row].valueForKey("task_image")!)") != nil){
//                            
//                            let url = NSURL(string: "\(tasks[indexPath.row].valueForKey("task_image")!)")
//                            if(NSData(contentsOfURL: url!) != nil){
//                                let data = NSData(contentsOfURL: url!)
//                                cell.taskImage.image = UIImage(data: data!)
//                            }else{
//                                print("Data Nil")
//                            }
                    }
                    
                    }
                        }else{
                            print("Error NIL")
                        }
                        
                        
                        
//                        taskTitles.append(cell.taskName.text!)
//                        
//                        cell.taskVideo = String(tasks[indexPath.row].valueForKey("task_video")!)
                    
                    }
                    catch{
                        print("Helko")
                    }
//                }
//            }
        
        collectionView.reloadData()
    }
    
    //Segues to next view when cell is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
         realTaskId = (collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell).taskIdentifier
        
        self.performSegueWithIdentifier("showSteps", sender: indexPath)
        
        
        let video = (collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell).taskVideo
        
        taskId = (collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell).taskIdentifier
        taskVideoss = video
       
        
        
        
        
        
        
        //self.presentViewController(vc, animated: true, completion: nil)
        //self.viewDidLoad()
    }
    
    
    //Passes data to next view during segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        
        if segue.identifier == "showSteps" {
            let tabView: UITabBarController = segue.destinationViewController as! UITabBarController
            
            //tabView.navigationItem.title = taskTitles[sender!.row]
            
             tabView.navigationItem.title = (collectionView.cellForItemAtIndexPath(sender as! NSIndexPath) as! CustomCollectionViewCell).taskName.text
        }
    }


    func loader()
        {
           /* if(viewcontrollerloadedalready == false){
            deleteAllData("TaskTable")
            deleteAllData("StepsTable")
            deleteAllData("LocationsTable")
            */
//            getLocationDatas.downloadItems("commands") {
//                (result: String) in
//                print("got back: \(result)")
//                }
//                
              //getTasksData.downloadItems()
            
//            getStepsData.downloadItems("commands") {
//                (result: String) in
//                print("got back: \(result)")
//                }
        
            getTaskStepsData.downloadItems()
            
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                getStudentTaskLocationData.downloadItems()
            }
            
            let time3 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
            dispatch_after(time3, dispatch_get_main_queue()) {
                //Put your code which should be executed with a delay here
                getTasksData.downloadItems()
            }
            
            let time4 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
            dispatch_after(time4, dispatch_get_main_queue()) {
                getLocationDatas.downloadItems()
            }

      let time2 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 4 * Int64(NSEC_PER_SEC))
            dispatch_after(time2, dispatch_get_main_queue()) {
           //Put your code which should be executed with a delay here
                getStepsData.downloadItems()
            }

           // NSNotificationCenter.defaultCenter().postNotificationName("retrievedAllDataFromPHPScript", object: nil, userInfo: nil)
            

            print("All Data Downloaded!")
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loader()
   
        
        if NSUserDefaults.standardUserDefaults().objectForKey("phoneNum") == nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let phoneController = storyboard.instantiateViewControllerWithIdentifier("login") as! phoneNumController
            self.navigationController?.pushViewController(phoneController, animated: true)
            
        }
        
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
        //setupData("Fike", radius: 100, Address: "110 Heisman St, Clemson, SC 29634")
        //setupData("Suntrust ATM", radius: 100, Address: "527 Fort Hill St, Clemson, SC 29634")
        //setUpLocations()
        
        viewcontrollerloadedalready = true
        //read()
        //setUpLocations()
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.read), name: "retrievedAllDataFromPHPScript", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.setUpLocations), name: "retrievedAllDataFromPHPScript", object: nil)
        
        self.collectionView.reloadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "retrievedAllDataFromPHPScript", object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        

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

        
        read()

        self.collectionView.reloadData()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "retrievedAllDataFromPHPScript", object: nil)
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
            //access coredata and load elements to be sent to setUpData
            let results: [AnyObject]  =  try context.executeFetchRequest(request)
            
                for result:AnyObject in results{
                    print("printing results")
                    let locationInt:Int = result.valueForKey("location_id") as! Int!
                    print(result.valueForKey("location_id")!)
                    let locationID = String(locationInt)
                    let locationName:String = result.valueForKey("location_name") as! String!
                    print(result.valueForKey("location_name")!)
                    let locationAddress:String = result.valueForKey("location_address") as! String!
                    print(result.valueForKey("location_address")!)
                    let locationRadius:Double = result.valueForKey("location_radius") as! Double!
                    print(result.valueForKey("location_radius")!)
                    
                    let url = NSURL(string: "\(result.valueForKey("location_photo")!)")
                    
                   //populate the dictionary with url so that way pics can be loaded
                   urlDictionary[locationID] = url
                    
                   //populate the dictionary with locationID
                    idDictionary[locationID] = locationName
                
                  
                    setupData(locationID, radius: locationRadius, Address: locationAddress)

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
                        
                        print("coordinates: \(coordinate)")
                        
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
        //get the current location of the 
        TaskLocation = region.identifier
        taskText = idDictionary[TaskLocation]!
        currentLocation.text = taskText
        
        //fetch the url from dictionary and convert to media
        let url = urlDictionary[TaskLocation]
        let data = NSData(contentsOfURL: url!)
        locationImage.image = UIImage(data: data!)
        
        print(taskText)
        print(TaskLocation)
    }
    
    //user exit region this will set the users current task location to null
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        TaskLocation = "All"
        taskText = "All"
        currentLocation.text = taskText
        print(TaskLocation)
        //showAlert("exit \(region.identifier)")
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }



}

