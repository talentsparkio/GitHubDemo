//
//  ViewController.swift
//  GitHubDemo
//
//  Created by Nick Chen on 7/28/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class GitHubOrgLandingViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
        spinner.hidesWhenStopped = true
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        GitHubOrganization().fetchOrganizationDetails { (org: GitHubOrganization.Organization) -> () in
            self.organizationLabel.text = org.organizationName
            self.descriptionLabel.text = org.description
            self.locationLabel.text = org.location
            
            if let url = NSURL(string: org.avatarURL) {
                if let data = NSData(contentsOfURL: url){
                    self.avatar.contentMode = UIViewContentMode.ScaleAspectFit
                    self.avatar.image = UIImage(data: data)
                } else {
                    self.avatar.image = UIImage(named: "World")
                }
            }
            
            self.spinner.stopAnimating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

