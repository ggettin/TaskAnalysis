//
//  StepCell.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/14/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit

class StepCell: UITableViewCell {

    @IBOutlet var stepImage: UIImageView!
    
    @IBOutlet var stepCount: UILabel!
    
    @IBOutlet var stepDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
