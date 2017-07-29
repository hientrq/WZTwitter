//
//  UIImageView+DownloadImage.swift
//  Twiitter
//
//  Created by Hien Quang Tran on 9/28/16.
//  Copyright © 2016 Hien Tran. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageWithUrl(_ url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let task = session.downloadTask(with: url, completionHandler: { (url, response, error) in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                self.image = image
                
            } else {
                print("Error download image \(error?.localizedDescription)")
            }
        }) 
        task.resume()
        return task
    }
}
