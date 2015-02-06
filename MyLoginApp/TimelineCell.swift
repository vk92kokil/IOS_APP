//
//  TimelineCellTableViewCell.swift
//  MyLoginApp
//
//  Created by Vikramaditya on 2/5/15.
//  Copyright (c) 2015 Vikramaditya. All rights reserved.
//

import UIKit
import Foundation

class TimelineCell: UITableViewCell {
    //var typeImageView : UIImageView!
    //@IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var dateImageView : UIImageView!
    //var photoImageView : UIImageView?
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var postView: UITextView!
    
    var width:CGFloat = UIScreen.mainScreen().bounds.size.width
    var height:CGFloat = UIScreen.mainScreen().bounds.size.height
    override func awakeFromNib() {
        //super.awakeFromNib()
        
        //.bounds.size.width
        // Initialization code
        dateImageView.image = UIImage(named: "clock")
        //profileImageView.layer.cornerRadius = 30
        
        nameLabel.font = UIFont(name: "Avenir-Book", size: 16)
        nameLabel.textColor = UIColor.blackColor()
        
        postView?.font = UIFont(name: "Avenir-Book", size: 14)
        postView?.textColor = UIColor(white: 0.6, alpha: 1.0)
        
        dateLabel.font = UIFont(name: "Avenir-Book", size: 14)
        dateLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        
        //photoImageView?.layer.borderWidth = 0.4
        //photoImageView?.layer.borderColor = UIColor(white: 0.92, alpha: 1.0).CGColor
    }
    /*override func layoutSubviews() {
        super.layoutSubviews() 
        if postView != nil {
            let label = postView!
            label.preferredMaxLayoutWidth = CGRectGetWidth(label.frame)
        }
    }*/
}
