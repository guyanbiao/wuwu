//
//  ViewController.swift
//  myFirstSwift
//
//  Created by neal gu on 14-6-11.
//  Copyright (c) 2014年 seven digital. All rights reserved.
//

import UIKit
import Foundation


let SeverUrl = "127.0.0.1:3000"

func MainThread(block: Void -> Void) {
    dispatch_async(dispatch_get_main_queue(), block)
}



func login(a: String, b: String, callback: (String, String?) -> Void) {
    var url = NSURL(string: "http://\(SeverUrl)/user/sessions")
    var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/api/sessions"))
    request.HTTPMethod = "POST"
    request.HTTPBody = "user[email]=\(a)&user[password]=\(b)".dataUsingEncoding(NSUTF8StringEncoding)

    var response: AutoreleasingUnsafePointer<NSURLResponse?>=nil


    var received = NSURLConnection.sendSynchronousRequest(request,  returningResponse:response, error:nil)
    
    var session = NSURLSession.init(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var err: NSError?
    
    var user:String
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        if (error) {
            callback("", error.localizedDescription)
        } else {
            var rs = response as NSHTTPURLResponse
            
            var all = NSHTTPCookie.cookiesWithResponseHeaderFields(rs.allHeaderFields, forURL: NSURL.URLWithString("http://temp"));
            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(all, forURL: NSURL.URLWithString("http://temp"), mainDocumentURL:nil)
            
            for i : AnyObject in all {
                println(i)
            }

            callback(NSString(data: data,
                encoding: NSUTF8StringEncoding), nil)
        }
        
    })
    task.resume()
}


class ViewController: UIViewController {
    
    
    @IBOutlet var email : UITextField
    @IBOutlet var password : UITextField
    override func supportedInterfaceOrientations() -> Int {
        return 2
        //TODO
    }
    

    
    func halfOpenRangeLength(start: Int, end: Int) -> Int {
        return end - start
    }
    
    func alert_message(message: String) -> Void{
        dispatch_async(dispatch_get_main_queue(), {

        var alert = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    @IBAction func abc(sender : AnyObject) {
        var emailText = email.text
        var passwordText = password.text
        
        login(emailText, passwordText, {
            (data: String, error: String?) -> Void in
            if error {
                if let error = error {
                    self.alert_message("连接失败")
                }
            } else {
                println(data)
                var perror: NSError?
                let jsonDict = NSJSONSerialization.JSONObjectWithData(data.dataUsingEncoding(NSUTF8StringEncoding), options: nil, error: &perror) as NSDictionary
                
                if jsonDict.objectForKey("user") {
                    var storybboard = self.storyboard
                    var hmc : AnyObject! = storybboard.instantiateViewControllerWithIdentifier("hmc")
                    MainThread {
                      self.navigationController.pushViewController(hmc as UIViewController, animated: true);
                    }
                } else {
                    let error_message:NSString = jsonDict.objectForKey("error") as NSString
                    self.alert_message(error_message)
                }
            }
         })
        
        

    }
    
    


    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

