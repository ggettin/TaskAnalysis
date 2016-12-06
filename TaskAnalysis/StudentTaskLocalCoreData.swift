//
//  StudentTaskLocalCoreData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/28/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData

extension StudentTaskLocalTable {
    
    @NSManaged var stl_id: NSNumber?
    @NSManaged var student_id: NSNumber?
    @NSManaged var student_location_id: NSNumber?
    @NSManaged var task_id: NSNumber?
    
}