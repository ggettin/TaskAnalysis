//
//  LoginCoreData.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/28/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation
import CoreData

extension LoginTable {
    
    @NSManaged var delete_id: NSNumber?
    @NSManaged var student_id: NSNumber?
    @NSManaged var student_name: NSString?
    @NSManaged var student_phone_number: NSString?
    @NSManaged var timestamp: NSDate

}