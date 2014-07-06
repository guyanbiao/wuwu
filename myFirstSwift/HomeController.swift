//
//  HomeController.swift
//  myFirstSwift
//
//  Created by neal gu on 14-6-30.
//  Copyright (c) 2014年 seven digital. All rights reserved.
//

import UIKit


class HomeController: UIViewController {
    override func viewDidLoad() {
        HTTPGet("http://127.0.0.1:3000/home/index.json") {
            (data: String, error: String?) -> Void in
            if (error) {
              println(error)
            } else {
                println(data)
            }
        }
        
        super.viewDidLoad()
    }
    

}