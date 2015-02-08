//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/2/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var movieCollection: [MovieModel]?
    var selectedMovieIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        getMovieList()
    }
    
    func getMovieList(){
        DataManager.getMovieList(){(movies: [MovieModel]?) in
            self.movieCollection = movies
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movieCollection{
            return movies.count
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.mycell") as MovieTableCellView
        
        //cell.movieDescription?.text = description ?? " No description. "
        
        var currentMovie = movieCollection![indexPath.row]
        
        cell.movieTitleLabel?.text = currentMovie.title ?? " No title "
        cell.movieDescription?.text = currentMovie.synopsis ?? " No description "
        
        if let url = currentMovie.imgOriginalUrl{
            //var placeholder = UIImage(contentsOfFile: "clapper.png")
            //cell.imageView?.image = placeholder
            cell.moviePoster.setFadeImageWithUrl(url)
        }
        //var URL = NSURL(string: "http://content6.flixster.com/movie/11/17/87/11178752_tmb.jpg")
        
        
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
                if let index = self.selectedMovieIndex? {
                    if let movie = self.movieCollection?[index]{
                        destinationController.movieDetails = movie
                    }
                }
            }
        }
    }
    

}

