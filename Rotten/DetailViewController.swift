//
//  DetailViewController.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/4/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movieDetails: NSDictionary?
    var movieThumbnail: UIImage?
    var moviePosters: NSDictionary?
    
    //TODO: place in global place
    var imageCache = [String : UIImage]()
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //moviePoster.setImageWithURL(<#url: NSURL!#>)
        
        if movieDetails != nil {
            var movieTitle = movieDetails?["title"] as? String ?? "No title"
            title = movieTitle
            
            if movieThumbnail != nil{
                moviePoster.image = movieThumbnail!
            }
            
            moviePosters = movieDetails!["posters"] as NSDictionary?
            var moviePosterUrl = moviePosters?["thumbnail"] as? String ?? ""

            if moviePosterUrl != "" {
                
                let urlString = moviePosterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
                var image = self.imageCache[urlString]
                
                let url = NSURL(string: urlString)
                let urlSmall = NSURL(string: moviePosterUrl)
                
                //let request: NSURLRequest = NSURLRequest(URL: url!)
                
                if(image == nil){
                    NSLog("Attempting to load image...")
                    /*NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                        if error == nil {
                            dispatch_async(dispatch_get_main_queue(),{
                                self.imageCache[urlString] = UIImage(data: data!)
                                self.moviePoster.image = self.imageCache[urlString]
                            })
                        }else{
                            NSLog("Image failed to load")
                        }
                    })*/
                    moviePoster.setImageWithURL(urlSmall)
                }else{
                    NSLog("Loading image from cache...")
                    dispatch_async(dispatch_get_main_queue(),{
                        self.moviePoster.image = image
                    })
                }
            }
        }else{
            title = "Uh oh!"
        }
    }
    
}
