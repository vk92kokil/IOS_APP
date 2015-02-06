//
//  SignupVC.swift
//  MyLoginApp
//
//  Created by Vikramaditya on 2/2/15.
//  Copyright (c) 2015 Vikramaditya. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var txt_userName: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    @IBOutlet weak var txt_confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUp(sender: AnyObject) {
        
       // println("\(txt_password) and \(txt_confirmPassword)")
        
        if(txt_userName.text == nil || txt_password == nil || txt_confirmPassword == nil){
            // error
            println("Empty fields found!! ")
        }
        else if(txt_password.text != txt_confirmPassword.text){
            //error
            println("Passwords do not match!!")
        }
        else{
        
            println("Saving data ")
            NSUserDefaults.standardUserDefaults().setObject(txt_userName.text, forKey: "username")
            NSUserDefaults.standardUserDefaults().setObject(txt_password.text, forKey: "password")
            NSUserDefaults.standardUserDefaults().synchronize()
        
            var alert = UIAlertController(title: "Congrats!!", message: "Registered Successfully", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title:"OK",style:UIAlertActionStyle.Default){
               action in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)

        }
    }

    @IBAction func goToLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func isValidEmail(testStr:String) -> Bool {
        println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest?.evaluateWithObject(testStr)
        return result!
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
