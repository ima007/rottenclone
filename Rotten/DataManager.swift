//
//  DataManager.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

struct DataManager{
    static let YourApiKey = "efm9t24v3b3umg9j64vpxrjc"
    
    static func getMovieList(success:(movies: NSArray?) -> Void){
        
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            
            success(movies: dictionary["movies"] as NSArray?)
        })
    }
}
