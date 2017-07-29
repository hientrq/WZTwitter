//
//  TweetViewController.swift
//  Twiitter
//
//  Created by Hien Quang Tran on 9/28/16.
//  Copyright © 2016 Hien Tran. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var createAtLabel: UILabel!
    
    @IBOutlet weak var retweetsCountLabel: UILabel!
    
    @IBOutlet weak var likesCountLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        setupAppearance()
    }
    
    func setupAppearance() {
        shareButton.backgroundColor = AppThemes.themeColor
        shareButton.layer.cornerRadius = 10
        shareButton.titleLabel?.textColor = UIColor.white
        
    }
    
    func updateUI() {
        nameLabel.text = tweet.owner.name
        screenNameLabel.text = "@" + (tweet.owner.screenName)
        contentLabel.text = tweet.tweetText
        createAtLabel.text = tweet.timeCreated
        
        if let url = URL(string: tweet.owner.profileImageUrl) {
            profileImageView.downloadImageWithUrl(url)
        } else {
            profileImageView.image = UIImage(named: "No Photo")
        }
        
        retweetsCountLabel.text = String(format: "%d", tweet.retweetCount)
        likesCountLabel.text = String(format: "%d", tweet.favCount)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let textToShare = "@" + tweet.owner.screenName +  "tweets " + tweet.tweetText
        let activityController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
