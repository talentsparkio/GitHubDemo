//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import Alamofire

// You need this so that we will wait for the results of async tasks
XCPSetExecutionShouldContinueIndefinitely(true)

// This is how to do it from scratch

let url = NSURL(string: "https://api.github.com/users/vazexqi")!
let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
    data, response, error in
        print(data)
        print(response)
        print(error)
}

task.resume()

// This is how to do it using Alamofire
Alamofire.request(.GET, "https://api.github.com/users/vazexqi")
    .responseJSON { request, response, json, error in
        print(request)
        print(response)
        print(json)
        print(error)
}
