//
//  ViewController.swift
//  Twiitter
//
//  Created by Hien Quang Tran on 9/28/16.
//  Copyright © 2016 Hien Tran. All rights reserved.
//

import UIKit
import MBProgressHUD

class UserHomeTimeline: UIViewController {
    
    let userProfileUrlString = "https://wizetwitterproxy.herokuapp.com/api/user"
    let tweetsUrlString = "https://wizetwitterproxy.herokuapp.com/api/statuses/user_timeline"

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var userProfile: Profile!
    
    var tweets: [Tweet] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        loadAPI()
        loadTweets()
        setupApperance()
    }
    
    //MARK: - Load User Profile
    func loadAPI() {
        let url = URL(string: userProfileUrlString)
        
        if let url = url {
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard response != nil else {
                    print("no response from server")
                    return
                }
                let httpStatusCode = (response as! HTTPURLResponse).statusCode
                if httpStatusCode == 200 && error == nil {
                    if let resultDict = self.parseJSON(data) {
                        print("parsing data")
                        self.userProfile = Profile(dictionary: resultDict)
                    }
                    
                    //update UI in the main thread
                    DispatchQueue.main.async {
                        self.updateUI()
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                } else {
                    print("status code: \(httpStatusCode)")
                    print("Load API error: \(error?.localizedDescription)")
                }
            })
            task.resume()
        } else {
            print("invalid Url")
        }
    }
    
    func parseJSON(_ data: Data?) -> [String: AnyObject]? {
        guard data != nil else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
        } catch {
            print("Parse dictionary error: \(error)")
            return nil
        }
    }
    
    //MARK: - Load Tweets
    func loadTweets() {
        let url = URL(string: tweetsUrlString)
        
        if let url = url {
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard response != nil else {
                    print("no response from server")
                    return
                }
                let httpStatusCode = (response as! HTTPURLResponse).statusCode
                if httpStatusCode == 200 && error == nil {
                    if let tweetsArray = self.parseJSONTweet(data) {
                        print("parsing tweet")
                        for tweetDict in tweetsArray {
                            if let tweetDict = tweetDict as? [String: AnyObject] {
                                let tweet = Tweet(dictionary: tweetDict)
                                self.tweets.append(tweet)
                            }
                        }
                    }
                    
                    //update UI in the main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                } else {
                    print("status code: \(httpStatusCode)")
                    print("Load API error: \(error?.localizedDescription)")
                }
            })
            task.resume()
        } else {
            print("invalid Url")
        }
    }
    
    func parseJSONTweet(_ data: Data?) -> [AnyObject]? {
        guard data != nil else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data!, options: []) as? [AnyObject]
        } catch {
            print("Parse dictionary error: \(error)")
            return nil
        }
    }
    
    
    //MARK: - Helpers
    func updateUI() {
        nameLabel.text = userProfile.name
        screenNameLabel.text = "@" + userProfile.screenName
        descriptionLabel.text = userProfile.profileDescription
        
        if let url = URL(string: userProfile.profileImageUrl) {
            profileImageView.downloadImageWithUrl(url)
        }
        
        if let url = URL(string: userProfile.backgroundImageUrl) {
            backgroundImageView.downloadImageWithUrl(url)
        }
    }
    
    func setupApperance() {
        profileImageView.layer.cornerRadius = 5
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.masksToBounds = true
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewTweet" {
            let controller = segue.destination as!  TweetViewController
            controller.tweet = sender as! Tweet
        }
    }
}

extension UserHomeTimeline: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ViewTweet", sender: tweets[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

