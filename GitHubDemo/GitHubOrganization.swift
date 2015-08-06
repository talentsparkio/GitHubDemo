//
//  GitHubOrganization.swift
//  GitHubDemo
//
//  Created by Nick Chen on 8/5/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class GitHubOrganization {
    static let DEFAULT_ORGANIZATION_NAME = "github"
    
    struct Organization {
        let avatarURL: String
        let organizationName: String
        let description: String
        let location: String
    }
    
    struct Member {
        let login: String
        let avatarUrl: String
    }
    
    public init() {}
    
    func fetchOrganizationDetails(callback: (Organization) -> ()) {
        // Fetch organization details
        Alamofire.request(.GET, "https://api.github.com/orgs/" + GitHubOrganization.DEFAULT_ORGANIZATION_NAME)
            .responseJSON { _, _, jsonObj, _ in
                self.populateOrganizationInfoWith(jsonObj, callback: callback)
        }
    }
    
    func fetchMembersDetails(callback: ([Member]) -> ()) {
        // Fetch organization members
        Alamofire.request(.GET, "https://api.github.com/orgs/" + GitHubOrganization.DEFAULT_ORGANIZATION_NAME + "/members")
            .responseJSON { _, _, jsonObj, _ in
                self.populateOrganizationMembersWith(jsonObj, callback: callback)
        }
        
    }
    
    func populateOrganizationInfoWith(data: AnyObject?, callback: (Organization) -> ()) {
        let json = JSON(data!)
        callback(Organization(avatarURL: json["avatar_url"].stringValue,organizationName: json["name"].stringValue, description: json["description"].stringValue, location: json["location"].stringValue))
    }
    
    func populateOrganizationMembersWith(data: AnyObject?, callback: ([Member]) -> ()) {
        let json = JSON(data!)
        var members = [Member]()

        for member in json.arrayValue {
            members.append(Member(login: member["login"].stringValue, avatarUrl: member["avatar_url"].stringValue))
        }
        
        callback(members)
    }
    
}