//
//  AllTasksCell.swift
//  TaskAnalysis
//
//  Created by Jordan Marro on 11/29/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit

class AllTasksCell: UITableViewCell {

    
    @IBOutlet var TaskLabel: UILabel!
    
    @IBOutlet var TaskImage: UIImageView!
    
    var taskVideo = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    
}
