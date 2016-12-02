//
//  TaskCoreData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/28/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData

extension TaskTable {
    
    @NSManaged var delete_id: NSNumber?
    @NSManaged var location_id: NSNumber?
    @NSManaged var task_id: NSNumber?
    @NSManaged var task_title: NSString?
    @NSManaged var task_video: NSString?
    @NSManaged var task_image: NSString?
    @NSManaged var timestamp: NSString?
}