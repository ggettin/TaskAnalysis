//
//  CustomCollectionViewCell.swift
//  TaskAnalysis
//
//  Created by Greg Gettings on 11/13/16.
//  Copyright © 2016 Greg Gettings. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var taskName: UILabel!
    
    @IBOutlet var taskImage: UIImageView!
    
    @IBOutlet var completionImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.layer.borderWidth = 10.0
        self.contentView.layer.borderColor = UIColor.clearColor().CGColor
        self.contentView.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).CGPath

    }
    
    
    


}
