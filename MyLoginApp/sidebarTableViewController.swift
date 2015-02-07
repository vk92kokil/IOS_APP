//
//  sidebarTableViewController.swift
//  blurrysidebar
//
//  Created by bakliwal archit on 04/02/15.
//  Copyright (c) 2015 bakliwal archit. All rights reserved.
//

import UIKit

protocol sidebarTableViewControllerDelegate
{
   func sidebarControlDidSelectRow(indexPath:NSIndexPath)
    
}

class sidebarTableViewController: UITableViewController {

    var  delegate:sidebarTableViewControllerDelegate?
    var tabledata:Array<String>=[]
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return tabledata.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?=tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell

        if cell == nil{
            cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkTextColor()
            
let selectview:UIView = UIView(frame : CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectview.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            cell!.selectedBackgroundView = selectview
        }
        
        cell!.textLabel?.text = tabledata[indexPath.row]
        
        return cell!
        }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sidebarControlDidSelectRow(indexPath)
    }
    
    
    }
    









