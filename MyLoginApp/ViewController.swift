//
//  ViewController.swift
//  MyLoginApp
//
//  Created by Vikramaditya on 2/2/15.
//  Copyright (c) 2015 Vikramaditya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FBLoginViewDelegate {
    var count:Int = 0
    var sidepanel:sidebar = sidebar()
    var NO_OF_POSTS:Int = Int()
    @IBOutlet weak var userName: UILabel!
    @IBOutlet var fbLoginView : FBLoginView!
    var width:CGFloat = UIScreen.mainScreen().bounds.size.width
    var height:CGFloat = UIScreen.mainScreen().bounds.size.height
    var imgView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let back_image = UIImage(named: "background.jpg")
        imgView = UIImageView(frame:view.bounds)
        imgView.image = back_image
        imgView.center = view.center
//        var size:CGSize = CGSizeMake(width, height)
//        var back_image:UIImage = imageResize(UIImage(named:"background.jpg")!, sizeChange: size)
        //self.view.backgroundColor = UIColor(patternImage:back_image)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.fbLoginView.delegate = self
        //self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        println("This is where you perform a segue.")
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        println("User Name: \(user.name)")
        userName.text = user.username
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    override func viewDidAppear(animated: Bool) {
        let isLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
        if(!isLoggedIn){
            self.performSegueWithIdentifier("goto_login", sender: self)
        }else{
            var uname:String!
            uname = NSUserDefaults.standardUserDefaults().stringForKey("username")
            userName.text = uname!
            println("Already logged in")
            sidepanel = sidebar(sourceview: self.view, menuitem: ["Home","Profile","Friends","Posts"])
        }
    }
    
    @IBAction func showHide(sender: UIBarButtonItem) {
        if(count%2==0){
            count = 1
            sidepanel.showsidebar(true)
        }
        else{
            count = 0
            sidepanel.showsidebar(false)
            
        }
    }

    
    @IBAction func logout(sender: UIBarButtonItem) {
        NSUserDefaults.standardUserDefaults().setBool(false,forKey: "isLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.performSegueWithIdentifier("goto_login", sender:self)
    }
    func imageResize (imageObj:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
}

