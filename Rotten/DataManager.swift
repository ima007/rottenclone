//
//  DataManager.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

enum ListType: Int {
    case Top = 0,  New, Upcoming, Current
    
    static func randomType() -> ListType {
        var maxValue: Int = 0
        while let _ = self(rawValue: ++maxValue) {}
        
        let rand = arc4random_uniform(UInt32(maxValue))
        return self(rawValue: Int(rand))!
    }
}

struct Urls{
    private static let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/"
    private static let YourApiKey = "efm9t24v3b3umg9j64vpxrjc"
    
    private static let MovieListOptions = ["box_office", "opening","upcoming","in_theaters"]
    private static let DvdListOptions = ["top_rentals", "new_releases", "upcoming", "current_releases"]
    
    private static func querystring(limit: Int) -> String{
        return "".join([".json?limit=",String(limit),"&apikey=",YourApiKey])
    }
    
    static func getMovieUrl(listType: ListType, limit: Int) -> String{
        let baseUrl = RottenTomatoesURLString + "movies/" + MovieListOptions[listType.rawValue]
        return baseUrl + querystring(limit)
    }
    
    static func getDvdUrl(listType: ListType, limit: Int) -> String{
        let baseUrl = RottenTomatoesURLString + "dvds/" + DvdListOptions[listType.rawValue]
        return baseUrl + querystring(limit)
    }
}

struct DataManager{
    
    private static let MovieListTitles = ["Box Office", "Opening", "Upcoming", "In Theaters"]
    private static let DvdListTitles = ["Top Rentals", "Current Releases", "Upcoming", "New Releases"]
    
    
    private static func makeMovieRequest(urlString: String, finished: (dictionary: NSDictionary, error: NSError?) -> Void){
        if let url = NSURL(string: urlString){
            
            let request = NSMutableURLRequest(URL: url)
            request.cachePolicy = .ReturnCacheDataElseLoad
        
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ response, data, error -> Void in
                if error != nil{
                    finished(dictionary: [String:AnyObject](), error: error)
                }else{
                    if let datas = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary {
                        finished(dictionary:datas, error: error)
                    }
                    
                }
            })
        }
    }
    
    
    static func getList(urlString: String, success:(movies: [MovieModel]) -> Void, error: () -> Void, always: () -> Void){
        makeMovieRequest(urlString, {(results, requestError) in
            var allMovies: [MovieModel]?
            allMovies <<<<* results["movies"]
            if let allMovies = allMovies{
                success(movies: allMovies)
            }else{
                error()
            }
            always()
        })
    }
    
    static func getMovieListTitle(listType: ListType) -> String{
        return MovieListTitles[listType.rawValue]
    }
    
    static func getDvdListTitle(listType: ListType) -> String{
        return DvdListTitles[listType.rawValue]
    }

}
