//
//  DetailViewController.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/4/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var movieDetails: MovieModel?
    
    @IBOutlet weak var mpaaRating: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!

    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollView.delegate = self
        var sizer = CGSize(width: 320, height: 1000)
        mainScrollView.contentSize = sizer
        scrollViewContent.sizeThatFits(sizer)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollViewContent
    }
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        NSLog("view did scroll")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        NSLog("view will begin dragging")

    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
        NSLog("user lifting finger")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        NSLog("user stopping scrolling")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movieDetails = movieDetails {
            title = movieDetails.title ?? "No title"
            
            setSectionTitle(movieDetails)
            
            synopsisLabel.text = movieDetails.synopsis
            synopsisLabel.sizeToFit()
            
            mpaaRating.text = movieDetails.mpaaRating
            
            setTomatometers(movieDetails)
            
            moviePoster.setFadeImageWithUrl(movieDetails)

        }else{
            title = "Uh oh!"
        }
    }
    
    func setSectionTitle(movieDetails: MovieModel){
        movieTitle.text = movieDetails.title
        if let year = movieDetails.year{
            movieTitle.text = movieTitle.text! + " (" + String(year) + ")"
        }
    }
    
    func setTomatometers(movieDetails:MovieModel){
        var ratingsText = [String]()
        if let criticsScore = movieDetails.ratingCriticsScore{
            ratingsText.append("Critics score: " + String(criticsScore))
        }
        if let audienceScore = movieDetails.ratingAudienceScore{
            ratingsText.append("Audience score: " + String(audienceScore))
        }
        if(ratingsText.count > 0){
            ratingLabel.text = ", ".join(ratingsText)
        }else{
            ratingLabel.text = "No ratings"
        }
    }
    
}
