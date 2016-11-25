//
//  MapViewController.swift
//  TaskAnalysis
//
//  Created by Brendan Giberson on 11/17/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

var TaskLocation: String = "none"

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //link to mapview for testing purposes
    @IBOutlet weak var mapView: MKMapView!
   
    //create locationManager
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad( )
    
    
    //setup locationManager
    locationManager.delegate = self
    locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()

    //setup mapView
    mapView.delegate = self
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .Follow
    
    //setup test data
    setupData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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

    func setupData() {
        // check if system can monitor regions
        if CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion.self) {
            
            //region data need to put in its own class to read multiple regions
            let title = "Test"
            let coordinate = CLLocationCoordinate2DMake(37.703026, -121.759735)
            let regionRadius = 300.0
            
            //setup region this will read an object with a saved coordinate and name
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoringForRegion(region)
            
            //setup annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate;
            annotation.title = "\(title)";
            mapView.addAnnotation(annotation)
            
            //setup circle
            let circle = MKCircle(centerCoordinate: coordinate, radius: regionRadius)
            mapView.addOverlay(circle)
        }
        else {
            print("System can't track regions")
        }
    }
    
    //draw circle
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.redColor()
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    //user enters region this will update the users current task location
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        showAlert("enter \(region.identifier)")
        TaskLocation = region.identifier
    }
    
    //user exit region this will set the users current task location to null
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        showAlert("exit \(region.identifier)")
        TaskLocation = "none"
        
    }
}