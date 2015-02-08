//
//  MovieModel.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

class MovieModel {
    private var JsonDictionary: NSDictionary?
    
    var id:String {
        return ""
    }
    
    init(JSONString:String){
        var error : NSError?
        
        
        if let JSONData = JSONString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            JsonDictionary = NSJSONSerialization.JSONObjectWithData(JSONData, options: nil, error: &error) as? NSDictionary
        }
    }
    
}