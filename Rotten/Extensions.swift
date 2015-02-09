//
//  Extensions.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/4/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func setFadeImageWithUrl(url: NSURL!){
        self.setFadeImageWithUrl(url, {})
    }
    
    func setFadeImageWithUrl(url: NSURL!, success: () -> Void){
        let fadeTime = 0.5
        self.alpha = 0
        
        var urlRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 10)
        
        self.setImageWithURLRequest(
            urlRequest,
            placeholderImage: UIImage(named: "placeholder"),
            success: {(urlRequest:NSURLRequest!, urlResponse:NSHTTPURLResponse!, image:UIImage!) in
                self.image = image
                UIView.animateWithDuration(fadeTime) {
                    self.alpha = 1
                }
                NSLog("loaded!")
                success()
            },
            failure: {(urlRequest:NSURLRequest!, urlResponse:NSHTTPURLResponse!, error:NSError!) in
                UIView.animateWithDuration(fadeTime) {
                    self.alpha = 1
                }
                NSLog("failed!")
            })
        
    }
    
    /**
     * Will automatically handle loading the low res thumbnail first, then load the original.
     */
    func setFadeImageWithUrl(movie: MovieModel){
        if let thumbnail = movie.imgThumbnailUrl{
            self.setFadeImageWithUrl(thumbnail){
                if let original = movie.imgOriginalUrl{
                    self.setFadeImageWithUrl(original, success: {})
                }
            }
        }
        
    }
}
