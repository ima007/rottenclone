//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/2/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var moviesArray:NSArray?
    var selectedMovieIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieList()
        /*
        moviesArray = [
            ["title":"Guardians of the Galaxy"],
            ["title":"Back to the Future"],
            ["title":"Star Wars: Episode 7"],
            [
                "id": "771249085",
                "title": "Spaceballs",
                "year": 2014,
                "mpaa_rating": "R",
                "runtime": 103,
                "critics_consensus": "",
                "release_dates": [
                    "theater": "2014-03-07",
                    "dvd": "2014-06-24"
                ],
                "ratings": [
                    "critics_rating": "Rotten",
                    "critics_score": 41,
                    "audience_rating": "Spilled",
                    "audience_score": 58
                ],
                "synopsis": "Based on Frank Miller's latest graphic novel Xerxes and told in the breathtaking visual style of the blockbuster \"300,\" this new chapter of the epic saga takes the action to a fresh battlefield-on the sea-as Greek general Themistokles (Sullivan Stapleton) attempts to unite all of Greece by leading the charge that will change the course of the war. \"300: Rise of an Empire\" pits Themistokles against the massive invading Persian forces led by mortal-turned-god Xerxes (Rodrigo Santoro), and Artemisia (Eva Green), vengeful commander of the Persian navy. (c) WB",
                "posters": [
                    "thumbnail": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg",
                    "profile": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg",
                    "detailed": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg",
                    "original": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg"
                ],
                "abridged_cast": [[
                    "name": "Sullivan Stapleton",
                    "id": "770706605",
                    "characters": ["Themistokles"]
                    ], [
                        "name": "Eva Green",
                        "id": "162652241",
                        "characters": ["Artemisia"]
                    ]],
                "alternate_ids": [
                    "imdb": "1253863"
                ],
                "links": [
                    "self": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085.json",
                    "alternate": "http://www.rottentomatoes.com/m/300_rise_of_an_empire/",
                    "cast": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085/cast.json",
                    "reviews": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085/reviews.json",
                    "similar": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085/similar.json"
                ]
            ],
            [
                "id": "771249085",
                "title": "300: Rise of an Empire",
                "year": 2014,
                "mpaa_rating": "R",
                "runtime": 103,
                "critics_consensus": "",
                "release_dates": [
                    "theater": "2014-03-07",
                    "dvd": "2014-06-24"
                ],
                "ratings": [
                    "critics_rating": "Rotten",
                    "critics_score": 41,
                    "audience_rating": "Spilled",
                    "audience_score": 58
                ],
                "synopsis": "Based on Frank Miller's latest graphic novel Xerxes and told in the breathtaking visual style of the blockbuster \"300,\" this new chapter of the epic saga takes the action to a fresh battlefield-on the sea-as Greek general Themistokles (Sullivan Stapleton) attempts to unite all of Greece by leading the charge that will change the course of the war. \"300: Rise of an Empire\" pits Themistokles against the massive invading Persian forces led by mortal-turned-god Xerxes (Rodrigo Santoro), and Artemisia (Eva Green), vengeful commander of the Persian navy. (c) WB",
                "posters": [
                    "thumbnail": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg",
                    "profile": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg",
                    "detailed": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg",
                    "original": "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg"
                ],
                "abridged_cast": [[
                "name": "Sullivan Stapleton",
                "id": "770706605",
                "characters": ["Themistokles"]
                ], [
                "name": "Eva Green",
                "id": "162652241",
                "characters": ["Artemisia"]
                ]],
                "alternate_ids": [
                    "imdb": "1253863"
                ],
                "links": [
                    "self": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085.json",
                    "alternate": "http://www.rottentomatoes.com/m/300_rise_of_an_empire/",
                    "cast": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085/cast.json",
                    "reviews": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085/reviews.json",
                    "similar": "http://api.rottentomatoes.com/api/public/v1.0/movies/771249085/similar.json"
                ]
            ]
        ]
        */
    }
    
    func getMovieList(){
        DataManager.getMovieList(){(movies: NSArray?) in
            self.moviesArray = movies
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = moviesArray{
            return movies.count
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.mycell") as MovieTableCellView
        let title = moviesArray![indexPath.row]["title"] as? String
        let description = moviesArray![indexPath.row]["synopsis"] as? String
        //let thumbnailUrl = moviesArray![indexpath.row]["posters"]
        
        cell.movieTitleLabel?.text = title ?? " No title "
        cell.movieDescription?.text = description ?? " No description. "
        
        var URL = NSURL(string: "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg")
        var placeholder = UIImage(contentsOfFile: "clapper.png")
        cell.imageView?.image = placeholder
        cell.imageView?.setImageWithURL(URL)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("row: \(indexPath.row)")
        selectedMovieIndex = indexPath.row
        self.performSegueWithIdentifier("ShowDetailSegue", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("preparing for segue! \(selectedMovieIndex)")
        if segue.identifier == "ShowDetailSegue"
        {
            if let destinationController = segue.destinationViewController as? DetailViewController{
                if self.selectedMovieIndex != nil {
                    var selectedMovie = self.moviesArray?[self.selectedMovieIndex!] as NSDictionary?
                    destinationController.movieDetails = selectedMovie
                }
            }
        }
    }
    

}

