//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/2/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movieCollection: [MovieModel]?
    var selectedMovieIndex:Int?
    var refreshControl: UIRefreshControl?
    var isTheater = true
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarInit()
        
        setRefreshControl()

        getInitialMovieList()
        
    }
    
    func setTabBarInit(){
        isTheater = self.tabBarController?.selectedIndex == 0
        
        var items = self.tabBarController?.tabBar.items as [UITabBarItem]
        items[0].title = "Movies"
        items[1].title = "DVDs"
        
        title = isTheater ? "Movies" : "DVDs"
    }
    
    func setRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl!, atIndex: 0)
    }
    
    /**
     * Retrieves movie list. Meant for intial view load.
     */
    func getInitialMovieList(){
        let movieListType = ListType.Top
        getMovieList(movieListType, limit: 20, toggleHud: true){}
    }
    
    func showErrorNotification(){
        var customFrame = self.errorView.frame
        customFrame.origin.x = 24
        customFrame.origin.y = 44
        
        self.errorView.frame = customFrame
        
        self.navigationController?.navigationBar.insertSubview(self.errorView, belowSubview: self.navigationController!.navigationBar)
    }
    
    func hideErrorNotification(){
        errorView.removeFromSuperview()
    }
    
    func getMovieList(listType: ListType, limit:Int, toggleHud:Bool, always: ()->()){
        var Url = isTheater ? Urls.getMovieUrl(listType, limit: limit) : Urls.getDvdUrl(listType, limit: limit)
        if(toggleHud){
            SVProgressHUD.show()
        }
        DataManager.getList(Url,
            {(movies: [MovieModel]?) in
                self.hideErrorNotification()
                self.movieCollection = movies
                self.tableView.reloadData()
                self.title = self.isTheater ? DataManager.getMovieListTitle(listType) : DataManager.getDvdListTitle(listType)
            },
            error: {
                self.showErrorNotification()
            },
            always:{
                if(toggleHud){
                    SVProgressHUD.dismiss()
                }
                always()
            })
    }
    
    /**
     * Retrieves one of four movie lists, at random.
     */
    func onRefresh() {
        var movieListType = ListType.randomType()
        getMovieList(movieListType, limit: 20, toggleHud: false){
            self.refreshControl!.endRefreshing()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movieCollection{
            return movies.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.mycell") as MovieTableCellView
        
        var currentMovie = movieCollection![indexPath.row]
        
        cell.movieTitleLabel?.text = currentMovie.title ?? " No title "
        cell.movieDescription?.text = currentMovie.synopsis ?? " No description "
        
        cell.moviePoster.setFadeImageWithUrl(currentMovie)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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

