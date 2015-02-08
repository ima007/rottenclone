//
//  DataManager.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

struct DataManager{
    private static let YourApiKey = "efm9t24v3b3umg9j64vpxrjc"
    private static let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + YourApiKey
    
    private static func makeMovieRequest(finished: (dictionary: NSDictionary) -> Void){
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            
            finished(dictionary: NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary);
        })
    }
    
    static func getMovieList(success:(movies: [MovieModel]) -> Void){
        makeMovieRequest({results in
            var allMovies: [MovieModel]?
            allMovies <<<<* results["movies"]
            if let allMovies = allMovies{
                success(movies: allMovies)
            }
        })
    }
    
    static func getMovieList(success:(movies: NSArray?) -> Void){
        makeMovieRequest({results in
            success(movies: results["movies"] as NSArray?)
        })
    }
}
