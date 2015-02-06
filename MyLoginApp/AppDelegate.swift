//
//  AppDelegate.swift
//  MyLoginApp
//
//  Created by Vikramaditya on 2/2/15.
//  Copyright (c) 2015 Vikramaditya. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //
        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.143:3000/login")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["username":"test1", "password":"1234"] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Success: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        task.resume()
        
        // Override point for customization after application launch.
        
        //Parse.setApplicationId("Qu7IyRqgbEmBE6CAqh4btyjJvPFAh1kjSq2ZCaSV", clientKey: "s6XJpsENNk0sfadW7F6jXrRGdJwJyVRi35YhjO7q" )
        
        //var testObject:PFObject = PFObject(className:"TestObject")
        //testObject["foo"] = "bar";
        //testObject.setObject("user1",forKey:"user")
        //testObject.save();
        UINavigationBar.appearance().barTintColor = UIColor.grayColor()
        UINavigationBar.appearance().tintColor = UIColor.blueColor()
        FBLoginView.self
        FBProfilePictureView.self
        return true
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: NSString?, annotation: AnyObject) -> Bool {
        
        var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        return wasHandled
        
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

