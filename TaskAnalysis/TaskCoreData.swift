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
    
    @NSManaged var deleted_id: NSNumber?
    @NSManaged var location_id: NSNumber?
    @NSManaged var task_id: NSNumber?
    @NSManaged var task_title: NSString?
    @NSManaged var task_video: NSURL?
    @NSManaged var timestamp: NSDate?
}