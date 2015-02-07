
//
//  sidebar.swift
//  blurrysidebar
//
//  Created by bakliwal archit on 04/02/15.
//  Copyright (c) 2015 bakliwal archit. All rights reserved.
//

import UIKit

@objc protocol sidebarDelegate {
    func sidebarSelectButtonIndex(index:Int)
    optional func sidebarwillopen()
    optional func sidebarwillclose()
    
}

class sidebar: NSObject, sidebarTableViewControllerDelegate {
    
    
    var barwidth:CGFloat = 150.0
    var sidebartopinset:CGFloat = 64.0
    var containerview:UIView = UIView()
    var controller:sidebarTableViewController = sidebarTableViewController()
    var originview:UIView!
    
    var animator : UIDynamicAnimator!
    var delegate :sidebarDelegate?
    var issidebaropen:Bool = false
    
    override init()
    {
        super.init()
        
    }
    init (sourceview:UIView , menuitem:Array<String>)
    {
        super.init()
        originview=sourceview
        //var tmp:sidebarTableViewController = sidebarTableViewController()
        
        controller.tabledata = menuitem
        
        setupsidebar()
        
        
        animator = UIDynamicAnimator(referenceView: originview)
        
        let show:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleswipe:")
        show.direction=UISwipeGestureRecognizerDirection.Right
        originview.addGestureRecognizer(show)
        
        let hide:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleswipe:")
        hide.direction=UISwipeGestureRecognizerDirection.Left
        originview.addGestureRecognizer(hide)
    }
    
    func setupsidebar()
    {
        containerview.frame = CGRectMake(-barwidth-1.0 , originview.frame.origin.y, barwidth, originview.frame.size.height)
        containerview.backgroundColor = UIColor.clearColor()
        containerview.clipsToBounds = false
        
        originview.addSubview(containerview)
        
        let blurview : UIVisualEffectView=UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blurview.frame=containerview.bounds
        containerview.addSubview(blurview)
        
        
        // = sidebarTableViewController()
        //sidebarTableViewController.delegate = self
        controller.delegate = self
        controller.tableView.frame = containerview.bounds
        controller.tableView.clipsToBounds = false
        controller.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        controller.tableView.backgroundColor = UIColor.clearColor()
        controller.tableView.scrollsToTop = false
        controller.tableView.contentInset = UIEdgeInsetsMake(sidebartopinset, 0, 0, 0)
        controller.tableView.reloadData()
        containerview.addSubview(controller.tableView)
        
        
    }
    
    func handleswipe(recognizer:UISwipeGestureRecognizer)
    {
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left
        {
            println("hiding side bar");
            showsidebar(false)
            delegate?.sidebarwillclose?()
            
        }
        else
        {
            showsidebar(true)
            println("showing side bar");
            delegate?.sidebarwillopen?()
            
            
            
        }
        
        
    }
    
    func showsidebar(shouldopen : Bool )
    {
        
        animator.removeAllBehaviors()
        issidebaropen = shouldopen
        
        let gravityx:CGFloat = (shouldopen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shouldopen) ? 20 : -20
        let boundaryx:CGFloat = (shouldopen) ? barwidth : (-barwidth-1.0)
        
        
        let gravitybehavior:UIGravityBehavior = UIGravityBehavior(items : [containerview])
        gravitybehavior.gravityDirection=CGVectorMake(gravityx, 0)
        animator.addBehavior(gravitybehavior)
        
        let colloisnbehavior :UICollisionBehavior = UICollisionBehavior (items : [containerview])
        colloisnbehavior.addBoundaryWithIdentifier("sidebar boundry", fromPoint: CGPointMake(boundaryx, 20), toPoint: CGPointMake(boundaryx, originview.frame.size.height))
        animator.addBehavior(colloisnbehavior)
        
        let pushbehavior:UIPushBehavior = UIPushBehavior( items : [containerview], mode : UIPushBehaviorMode.Instantaneous)
        pushbehavior.magnitude=magnitude
        animator.addBehavior(pushbehavior)
        
        let sidebarbehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items:[containerview])
        sidebarbehavior.elasticity = 0.3
        
        animator.addBehavior(sidebarbehavior)
    }
    
    func sidebarControlDidSelectRow(indexPath : NSIndexPath) {
        
        delegate?.sidebarSelectButtonIndex(indexPath.row)
        
    }
    
}


