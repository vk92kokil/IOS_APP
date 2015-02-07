//
//  PostViewController.swift
//  MyLoginApp
//
//  Created by Vikramaditya on 2/4/15.
//  Copyright (c) 2015 Vikramaditya. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var wordCount: UILabel!
    var filepath:String = "/Users/vikramaditya/Documents/abc.txt" //change if required
    
    var width:CGFloat = UIScreen.mainScreen().bounds.size.width
    var height:CGFloat = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidLoad() {
        textArea.layer.borderColor = UIColor.blueColor().CGColor
        textArea.layer.borderWidth = 0.5
        textArea.layer.cornerRadius = 5
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        
    }

    @IBAction func postMessage(sender: UIBarButtonItem) {
        if(!textArea.text.isEmpty){
            var str:NSString = "\(textArea.text)\n"
            var text:NSData = str.dataUsingEncoding(NSUTF8StringEncoding)!
            
            if NSFileManager.defaultManager().fileExistsAtPath(filepath) {
                var err:NSError?
                if let fileHandle = NSFileHandle(forWritingAtPath: filepath) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.writeData(text)
                    fileHandle.closeFile()
                }
                else {
                    println("Can't open fileHandle \(err)")
                }
            }
            
            var alert = UIAlertController(title: "Success", message: "Posted Successfully", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title:"OK",style:UIAlertActionStyle.Default){
                action in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController?.popViewControllerAnimated(true)
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            println("Empty message")
            var alert = UIAlertController(title: "Error", message: "Empty Message", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title:"OK",style:UIAlertActionStyle.Default){
                action in
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }

        //text.writeToFile("/Users/vikramaditya/Documents/abc.txt", atomically: true, encoding: NSUTF8StringEncoding, error: nil);
        
        //reading
        //let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        
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
