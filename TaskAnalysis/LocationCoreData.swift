//
//  LocationCoreData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/28/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData

extension LocationsTable {
    
    @NSManaged var delete_id: NSNumber?
    @NSManaged var location_id: NSNumber?
    @NSManaged var location_longitude: NSNumber?
    @NSManaged var location_latitude: NSNumber?
    @NSManaged var location_name: NSString?
    @NSManaged var location_photo: NSURL?
    @NSManaged var location_radius: NSNumber
    @NSManaged var location_address: NSString?
    @NSManaged var location_image: NSString?
    @NSManaged var timestamp: NSString?

    
}