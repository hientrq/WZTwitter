//
//  TweetCell.swift
//  Twiitter
//
//  Created by Hien Quang Tran on 9/28/16.
//  Copyright © 2016 Hien Tran. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstaint: NSLayoutConstraint!
    
    var tweet: Tweet! {
        didSet{
            nameLabel.text = tweet.owner.name
            screenNameLabel.text = "@" + (tweet.owner.screenName)
            contentLabel.text = tweet.tweetText
            timeStampLabel.text = tweet.timeSinceCreated
            retweetCountLabel.text = String(format: "%d", tweet.retweetCount)
            likeCountLabel.text = String(format: "%d", tweet.favCount)
            
            if let url = URL(string: tweet.owner.profileImageUrl) {
                profileImageView.downloadImageWithUrl(url)
            } else {
                profileImageView.image = UIImage(named: "noPhoto")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
