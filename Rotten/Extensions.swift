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
        let fadeTime = 0.5
        self.alpha = 0
        
        self.setImageWithURLRequest(
            NSURLRequest(URL: url),
            placeholderImage: UIImage(named: "placeholder"),
            success: {(urlRequest:NSURLRequest!, urlResponse:NSHTTPURLResponse!, image:UIImage!) in
                self.image = image
                UIView.animateWithDuration(fadeTime) {
                    self.alpha = 1
                }
                NSLog("loaded!")
            },
            failure: {(urlRequest:NSURLRequest!, urlResponse:NSHTTPURLResponse!, error:NSError!) in
                UIView.animateWithDuration(fadeTime) {
                    self.alpha = 1
                }
                NSLog("failed!")
            })
        
    }
}

extension Int {
    var asString: String{
        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        return formatter.stringFromNumber(self)!
    }
}
