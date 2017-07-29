//
//  Profile.swift
//  Twiitter
//
//  Created by Hien Quang Tran on 9/28/16.
//  Copyright © 2016 Hien Tran. All rights reserved.
//

import Foundation

class Profile: NSObject {
    var screenName = ""
    var name = ""
    var profileDescription = ""
    var profileImageUrl = ""
    var backgroundImageUrl = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        if let screenName = dictionary["screen_name"] {
            self.screenName = screenName as! String
        }
        
        if let name = dictionary["name"] {
            self.name = name as! String
        }
        
        if let profileDescription = dictionary["description"] {
            self.profileDescription = profileDescription as! String
        }
        
        if let profileImageUrl = dictionary["profile_image_url_https"] {
            self.profileImageUrl = profileImageUrl as! String
        }
        
        if let backgroundImageUrl = dictionary["profile_background_image_url_https"] {
            self.backgroundImageUrl = backgroundImageUrl as! String
        }
    }
}