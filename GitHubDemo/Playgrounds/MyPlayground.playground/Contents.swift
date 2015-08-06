//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import Alamofire
import SwiftyJSON

// You need this so that we will wait for the results of async tasks
XCPSetExecutionShouldContinueIndefinitely(true)

// This is how to do it from scratch

let url = NSURL(string: "https://api.github.com/orgs/github")!
let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
    _, response, _ in
    print(response)
}

task.resume()

// This is how to do it using Alamofire
Alamofire.request(.GET, "https://api.github.com/orgs/github")
    .responseJSON { _, _, data, _ in
        let json = JSON(data!)
        print(json["avatar_url"])
        print(json["name"])
        print(json["description"])
        print(json["location"])
}

Alamofire.request(.GET, "https://api.github.com/orgs/github/members")
    .responseJSON { _, _, data, _ in
        let json = JSON(data!)
        
        for member in json.arrayValue {
            print(member["login"].stringValue)
            print(member["avatar_url"].stringValue)
        }
}