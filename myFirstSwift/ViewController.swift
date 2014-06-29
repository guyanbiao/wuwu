//
//  ViewController.swift
//  myFirstSwift
//
//  Created by neal gu on 14-6-11.
//  Copyright (c) 2014年 seven digital. All rights reserved.
//

import UIKit

let SeverUrl = "127.0.0.1:3000"

func login(a: String, b: Int) -> Bool {
    var url = NSURL(string: "http://\(SeverUrl)/user/sessions")
    var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/users/sign_in"))

    var session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    var params = ["user[username]":"jameson", "user[password]":"password"] as Dictionary
    var err: NSError?
    request.HTTPBody = "user[email]=guyanbiao@163.com&user[password]=gg785236".dataUsingEncoding(NSUTF8StringEncoding)
    

    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        println("Response: \(response)")
    })
    
    task.resume()

    
    
    

    return false
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


    
    @IBAction func abc(sender : AnyObject) {
        var emailText = email.text
        var passwordText = password.text
        println("sssss")
        login("", 1)
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

