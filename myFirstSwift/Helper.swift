//
//  Helper.swift
//  myFirstSwift
//
//  Created by neal gu on 14-7-6.
//  Copyright (c) 2014年 seven digital. All rights reserved.
//

import Foundation

func HTTPsendRequest(request: NSMutableURLRequest,
    callback: (String, String?) -> Void) {
        var session = NSURLSession.init(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

        let task = session
            .dataTaskWithRequest(request) {
                (data, response, error) -> Void in
                if error {
                    callback("", error.localizedDescription)
                } else {
                    callback(NSString(data: data,
                        encoding: NSUTF8StringEncoding), nil)
                }
        }
        
        task.resume()
}

func HTTPGet(url: String, callback: (String, String?) -> Void) {
    var request = NSMutableURLRequest(URL: NSURL(string: url))
    var availableCookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL.URLWithString("http://temp"))
    
    var headers = NSHTTPCookie.requestHeaderFieldsWithCookies(availableCookies)
    request.allHTTPHeaderFields = headers;
    HTTPsendRequest(request, callback)
}

