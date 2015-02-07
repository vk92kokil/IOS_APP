//
//  ViewController.swift
//  NavTransition
//
//  Created by Tope Abayomi on 21/11/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

import Foundation
import UIKit

class TimelineViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    //@IBOutlet var menuItem : UIBarButtonItem!
    //@IBOutlet var toolbar : UIToolbar!
    var NO_OF_POSTS:Int = 0
    //var data:NSMutableArray = NSMutableArray()
    var array:NSArray = NSArray()
    var filePoiner:FileReader? // Optional FileReader for testing
    //var transitionOperator = TransitionOperator()
    var width:CGFloat = UIScreen.mainScreen().bounds.size.width
    var height:CGFloat = UIScreen.mainScreen().bounds.size.height
    var filepath:String = "/Users/vikramaditya/Documents/abc.txt" //change if required
    
    override func viewDidLoad() {
        //loadData()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100.0;
        //tableView.rowHeight = 44;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //menuItem.image = UIImage(named: "menu")
        //toolbar.tintColor = UIColor.blackColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NO_OF_POSTS
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //if (indexPath.row % 2 == 0) {
        
        let cell:TimelineCell = tableView.dequeueReusableCellWithIdentifier("TimelineCell",forIndexPath:indexPath) as TimelineCell
           // var cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as? UITableViewCell
            /*if(cell == nil){
                cell = UITableViewCell(style: UITableViewCellStyle.Value1,reuseIdentifier: "TimelineCell")
            }*/
            //cell?.textLabel?.text = NSString(format: "%d", indexPath.row)

            //cell.typeImageView.image = UIImage(named: "timeline-chat")
            //cell.profileImageView.image = UIImage(named: "profile-pic-1")
            var message:AnyObject = self.array.objectAtIndex(indexPath.row)
            //cell.nameLabel.text = "\(username)"
            cell.nameLabel.text = ""
            cell.postView.text = "\(message)"
        
            //cell.postView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            cell.dateLabel.text = "1 min ago"
            cell.layer.borderWidth = 5.0
            cell.layer.borderColor = UIColor.whiteColor().CGColor
           // cell.layer.b
        /*else{
            let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCellPhoto") as TimelineCell
            
            //cell.typeImageView.image = UIImage(named: "timeline-photo")
            cell.profileImageView.image = UIImage(named: "profile-pic-2")
            cell.nameLabel.text = "Linda Hoylett"
            //cell.photoImageView?.image = UIImage(named: "dish")
            cell.dateLabel.text = "2 mins ago"
            return cell
        }*/
        return cell
    }
    
    @IBAction func presentNavigation(sender: AnyObject?){
        performSegueWithIdentifier("presentNav", sender: self)
    }
    func loadData(){
        var data:NSMutableArray = NSMutableArray()
        data.removeAllObjects()
        NO_OF_POSTS = 0
        filePoiner = FileReader(path: filepath)
        while var line = filePoiner?.nextLine(){
            data.addObject(line)
            NO_OF_POSTS++
        }
        filePoiner?.close()
        var tmp:NSArray = data.reverseObjectEnumerator().allObjects
        self.array = tmp
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let toViewController = segue.destinationViewController as UIViewController
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        //toViewController.transitioningDelegate = self.transitionOperator
    }
}






