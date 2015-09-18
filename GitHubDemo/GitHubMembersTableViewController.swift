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

    // Currently this is an unbounded cache - you probably want to use something like a LRU
    var cachedImages = [String: UIImage]()
    
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
        
        loadOrFetchImageFor(member.login, avatarUrl: member.avatarUrl, cell: cell)
        
        return cell
    }

    func loadOrFetchImageFor(login: String, avatarUrl: String, cell: UITableViewCell) -> Void {
        if let image = cachedImages[login] { // already in cache
            cell.imageView?.image = image
        } else {
            if let url = NSURL(string: avatarUrl) { // need to fetch
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0))  {
                    if let data = NSData(contentsOfURL: url) {
                        if let avatarSquare = UIImage(data:data) {
                            let avatarCircle = UIImage.roundedRectImageFromImage(avatarSquare, imageSize: avatarSquare.size, cornerRadius: avatarSquare.size.width / 2)
                            self.cachedImages.updateValue(avatarCircle, forKey: login)
                            dispatch_async(dispatch_get_main_queue()) {
                                cell.imageView?.image = avatarCircle
                            }
                        }
                    }
                }
            }
        }
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
