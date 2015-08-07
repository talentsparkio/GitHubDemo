//
//  TableViewController.swift
//  GitHubDemo
//
//  Created by Nick Chen on 8/6/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class GitHubMembersTableViewController: UITableViewController {
    var members: [GitHubOrganization.Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GitHubOrganization().fetchMembersDetails { (members: [GitHubOrganization.Member]) -> () in
            self.members = members
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Members"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath: indexPath)
        
        let member = members[indexPath.row]
        cell.textLabel?.text = member.login
        
        if let url = NSURL(string: member.avatarUrl) {
            if let data = NSData(contentsOfURL: url){
                if let avatarSquare = UIImage(data: data) {
                    let avatarCircle = UIImage.roundedRectImageFromImage(avatarSquare, imageSize: avatarSquare.size, cornerRadius: avatarSquare.size.width / 2)
                    cell.imageView?.image = avatarCircle
                }
            }
        }
        
        return cell
    }
}

// http://stackoverflow.com/questions/7399343/making-a-uiimage-to-a-circle-form
extension UIImage {
    
    class func roundedRectImageFromImage(image: UIImage, imageSize: CGSize, cornerRadius: CGFloat)->UIImage {
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        let bounds = CGRect(origin: CGPointZero, size: imageSize)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        image.drawInRect(bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage
    }
    
}
