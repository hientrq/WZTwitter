//
//  Tweet.swift
//  Twiitter
//
//  Created by Hien Quang Tran on 9/28/16.
//  Copyright © 2016 Hien Tran. All rights reserved.
//
import UIKit
import Foundation

class Tweet {
    var screenName = ""
    var name = ""
    var tweetText = ""
    var profileImageUrl = ""
    var timeSinceCreated = "String"
    var timeCreated = ""
    var retweetCount = 0
    var favCount = 0
    var owner = Profile()
    
    init(dictionary: [String: AnyObject]) {
        if let tweetText = dictionary["text"] {
            self.tweetText = tweetText as! String
        }
        
        if let timeCreated = dictionary["created_at"] as? String,
            let time = getDateFromString(timeCreated, withFormat: DateStringFormat.EEE_MMM_d_HH_mm_ss_Z_yyyy) {
            self.timeCreated = getStringFromDate(time, withFormat: DateStringFormat.EEE_DD_MMM_YYYY_HH_mm)
            calculateTimeSinceCreated(time)
        }
        
        if let retweetCount = dictionary["retweet_count"] {
            self.retweetCount = retweetCount as! Int
        }
        
        if let favCount = dictionary["favorite_count"] {
            self.favCount = favCount as! Int
        }
        
        if let userInfo = dictionary["user"] as? [String: AnyObject] {
            self.owner = Profile(dictionary: userInfo)
        }
    }
    
    //calculate how long until current time since the tweet was created
    func calculateTimeSinceCreated(_ time: Date) {
        let elapsedTime = Date().timeIntervalSince(time)
        if elapsedTime < 60 {
            timeSinceCreated = String(Int(elapsedTime)) + "s"
        } else if elapsedTime < 3600 {
            timeSinceCreated = String(Int(elapsedTime / 60)) + "m"
        } else if elapsedTime < 24*3600 {
            timeSinceCreated = String(Int(elapsedTime / 60 / 60)) + "h"
        } else {
            timeSinceCreated = String(Int(elapsedTime / 60 / 60 / 24)) + "d"
        }
    }
}
