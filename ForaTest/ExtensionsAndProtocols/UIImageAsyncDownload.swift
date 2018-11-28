//
//  UIImageAsyncDownload.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 27/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        // using UIImage extension to async download data
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
    
}
