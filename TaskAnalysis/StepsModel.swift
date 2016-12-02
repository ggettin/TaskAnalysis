//
//  StepsModel.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/30/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import Foundation

class StepsModel: NSObject {
    
    //properties
    
    var step_id: Int?
    var step_number: Int?
    var step_info: String?
    var step_audio: String?
    var step_photo: String?
    var delete_id: Int?
    var timestamp: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(step_id: Int, step_info: String, step_number: Int, step_audio: String, step_photo: String, delete_id: Int, timestamp: String) {
        
        self.step_id = step_id
        self.step_number = step_number
        self.step_photo = step_photo
        self.step_audio = step_audio
        self.step_info = step_info
        self.delete_id = delete_id
        self.timestamp = timestamp
        
        
    }
    
    func getValues(step_id: Int, step_info: String, step_number: Int, step_audio: String, step_photo: String, delete_id: Int, timestamp: String){
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(step_id),NUMBER: \(step_number) INFO: \(step_info), AUDIO: \(step_audio), PHOTO: \(step_photo), DELETE: \(delete_id), TIMESTAMP: \(timestamp) "
        
    }
    
    
}