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
    
    //setup test data will need to link coredata to pass in (LocationLabel, radius, address)
        setupData("Test1", radius: 100, Address: "Redfern Health Center, Clemson, SC 29634")
        setupData("Test2", radius: 200, Address: "821 McMillan Rd, Clemson, SC 29634")
        setupData("Test3", radius: 300, Address: "720 McMillan Rd, Clemson, SC 29634")
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
            var region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate!.latitude,
                longitude: coordinate!.longitude), radius: regionRadius, identifier: title)
            self.locationManager.startMonitoringForRegion(region)
            
            //setup annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate!;
            annotation.title = "\(title)";
            self.mapView.addAnnotation(annotation)
            
            //setup circle
            let circle = MKCircle(centerCoordinate: coordinate!, radius: regionRadius)
            self.mapView.addOverlay(circle)
        }
        else {
            print("System can't track regions")
        }
                }
            }
        }
    }
    
    //draw circle
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKCircle
        {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.redColor()
        circleRenderer.lineWidth = 1.0
        return circleRenderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
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