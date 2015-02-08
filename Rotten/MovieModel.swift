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
    var criticsConsensus:String?
    var posters:[String:String]?
    var ratings:[String:AnyObject]?
    var ratingCritics:String?
    var ratingCriticsScore:Int?
    var ratingAudience:String?
    var ratingAudienceScore:Int?
    var runtime:Int?
    
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
    var imgOriginalUrl:NSURL?{
        if let imgUrl = imgOriginal{
            return NSURL(string: imgOriginal!)
        }
        return nil
    }

    
    required init(data: [String: AnyObject]) {
        id <<< data["id"]
        title <<< data["title"]
        year <<< data["year"]
        runtime <<< data["runtime"]
        synopsis <<< data["synopsis"]
        mpaaRating <<< data["mpaa_rating"]
        posters <<< data["posters"]
        ratings <<< data["ratings"]
        criticsConsensus <<< data["critics_consensus"]
        
        ratingCritics <<< ratings?["critics_rating"]
        ratingCriticsScore <<< ratings?["critics_score"]
        ratingAudienceScore <<< ratings?["audience_score"]
        ratingAudience <<< ratings?["audience_rating"]
    }
    
}



/*
{
"movies": [{
"id": "770687943",
"title": "Harry Potter and the Deathly Hallows - Part 2",
"year": 2011,
"mpaa_rating": "PG-13",
"runtime": 130,
"critics_consensus": "Thrilling, powerfully acted, and visually dazzling, Deathly Hallows Part II brings the Harry Potter franchise to a satisfying -- and suitably magical -- conclusion.",
"release_dates": {"theater": "2011-07-15"},
"ratings": {
"critics_rating": "Certified Fresh",
"critics_score": 97,
"audience_rating": "Upright",
"audience_score": 93
},
"synopsis": "Harry Potter and the Deathly Hallows - Part 2, is the final adventure in the Harry Potter film series. The much-anticipated motion picture event is the second of two full-length parts. In the epic finale, the battle between the good and evil forces of the wizarding world escalates into an all-out war. The stakes have never been higher and no one is safe. But it is Harry Potter who may be called upon to make the ultimate sacrifice as he draws closer to the climactic showdown with Lord Voldemort. It all ends here. -- (C) Warner Bros",
"posters": {
"thumbnail": "http://content8.flixster.com/movie/11/15/86/11158674_tmb.jpg",
"profile": "http://content8.flixster.com/movie/11/15/86/11158674_tmb.jpg",
"detailed": "http://content8.flixster.com/movie/11/15/86/11158674_tmb.jpg",
"original": "http://content8.flixster.com/movie/11/15/86/11158674_tmb.jpg"
},
"abridged_cast": [
{
"name": "Daniel Radcliffe",
"characters": ["Harry Potter"]
},
{
"name": "Rupert Grint",
"characters": [
"Ron Weasley",
"Ron Wesley"
]
},
{
"name": "Emma Watson",
"characters": ["Hermione Granger"]
},
{
"name": "Helena Bonham Carter",
"characters": ["Bellatrix Lestrange"]
},
{
"name": "Ralph Fiennes",
"characters": ["Lord Voldemort"]
}
],
"alternate_ids": {"imdb": "1201607"},
"links": {
"self": "http://api.rottentomatoes.com/api/public/v1.0/movies/770687943.json",
"alternate": "http://www.rottentomatoes.com/m/harry_potter_and_the_deathly_hallows_part_2/",
"cast": "http://api.rottentomatoes.com/api/public/v1.0/movies/770687943/cast.json",
"clips": "http://api.rottentomatoes.com/api/public/v1.0/movies/770687943/clips.json",
"reviews": "http://api.rottentomatoes.com/api/public/v1.0/movies/770687943/reviews.json",
"similar": "http://api.rottentomatoes.com/api/public/v1.0/movies/770687943/similar.json"
}
}],
"links": {
"self": "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=1&country=us",
"alternate": "http://www.rottentomatoes.com/movie/box_office.php"
},
"link_template": "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit={num-results}&country={country-code}"
}
*/