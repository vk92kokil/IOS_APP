//
//  LoginVCViewController.swift
//  MyLoginApp
//
//  Created by Vikramaditya on 2/2/15.
//  Copyright (c) 2015 Vikramaditya. All rights reserved.
//

import UIKit

class LoginVCViewController: UIViewController {

    @IBOutlet weak var txt_userName: UITextField!
    
    @IBOutlet weak var txt_Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        var fb:FBLoginView = FBLoginView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: UIButton) {
        
        let username = txt_userName.text
        let pass = txt_Password.text
        
        let storedUserName = NSUserDefaults.standardUserDefaults().stringForKey("username")
        let storedPass = NSUserDefaults.standardUserDefaults().stringForKey("password")
        println("\(storedUserName) and \(storedPass) \n")
        
        if(storedUserName == username){
            if(storedPass == pass){
                println("Login Successful")
                NSUserDefaults.standardUserDefaults().setValue(true, forKey: "isLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                println("Incorrect username or password")
            }
        }
    }
    func post(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:4567/login")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["username":"jameson", "password":"password"] as Dictionary<String, String>
        
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
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
