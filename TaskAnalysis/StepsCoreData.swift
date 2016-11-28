//
//  StepsCoreData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/28/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData

extension StepsTable {
    
    @NSManaged var delete_id: NSNumber?
    @NSManaged var step_audio: NSURL?
    @NSManaged var step_id: NSNumber?
    @NSManaged var step_info: NSString?
    @NSManaged var step_number: NSNumber?
    @NSManaged var step_photo: NSURL?
    @NSManaged var timestamp: NSDate?
}