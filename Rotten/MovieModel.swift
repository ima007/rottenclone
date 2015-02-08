//
//  MovieModel.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

class MovieModel : Deserializable {
    
    
    var id:String?
    var title:String?
    var year:Int?
    var synopsis:String?
    var mpaaRating:String?
    var posters:[String:String]?
    var imgThumbnail:String?{
        return posters?["thumbnail"] ?? nil
    }
    var imgProfile:String?{
        return posters?["profile"] ?? nil
    }
    var imgDetailed:String?{
        return posters?["detailed"] ?? nil
    }
    var imgOriginal:String?{
        return imgThumbnail?.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil) ?? nil
    }
    var imgThumbnailUrl:NSURL?{
        if let imgUrl = imgThumbnail{
            return NSURL(string: imgThumbnail!)
        }
        return nil
    }
    
    required init(data: [String: AnyObject]) {
        id <<< data["id"]
        title <<< data["title"]
        year <<< data["year"]
        synopsis <<< data["synopsis"]
        mpaaRating <<< data["mpaa_rating"]
        posters <<< data["posters"]
    }
    
}