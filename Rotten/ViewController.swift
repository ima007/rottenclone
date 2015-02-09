//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Shane Afsar on 2/2/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var movieCollection: [MovieModel]?
    var filteredMovieCollection = [MovieModel]()
    var selectedMovieIndex:Int?
    var refreshControl: UIRefreshControl?
    var isTheater = true
    var isFiltering = false
    
    @IBOutlet weak var searchInput: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchInput.delegate = self
        
        setTabBarInit()
        
        setRefreshControl()

        getInitialMovieList()
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltering = !searchText.isEmpty

        filteredMovieCollection = movieCollection!.filter({( movie: MovieModel) -> Bool in
            let title = movie.title ?? ""
            let stringMatch = title.rangeOfString(searchText)
            return stringMatch != nil
        })
        tableView.reloadData()
        
        if(!isFiltering){
            searchBar.endEditing(true)
        }
        NSLog("\(filteredMovieCollection.count), \(searchText)")
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isFiltering = false
        self.tableView.reloadData()
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    
    func setTabBarInit(){
        isTheater = self.tabBarController?.selectedIndex == 0
        
        var items = self.tabBarController?.tabBar.items as [UITabBarItem]
        items[0].title = "Movies"
        items[0].image = UIImage(named: "theater@3x")
        items[1].title = "DVDs"
        items[1].image = UIImage(named: "dvd@3x")
        
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
        if isFiltering{
            return filteredMovieCollection.count
        }
        if let movies = movieCollection{
            return movies.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.mycell") as MovieTableCellView
        
        var currentMovie = isFiltering ? filteredMovieCollection[indexPath.row] : movieCollection![indexPath.row]
        
        cell.movieTitleLabel?.text = currentMovie.title ?? " No title "
        cell.movieDescription?.text = currentMovie.synopsis ?? " No description "
        
        cell.moviePoster.setFadeImageWithUrl(currentMovie)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("row: \(indexPath.row)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailSegue"
        {
            if(searchInput.text.isEmpty){
                searchInput.endEditing(true)
            }
            var selectedMovieIndexPath = self.tableView.indexPathForSelectedRow()
            
            NSLog("preparing for segue! \(selectedMovieIndexPath?.row)")
            
            if let destinationController = segue.destinationViewController as? DetailViewController{
                if let index = selectedMovieIndexPath?.row {
                    if let movie = isFiltering ? self.filteredMovieCollection[index] : self.movieCollection?[index]{
                        destinationController.movieDetails = movie
                    }
                }
            }
        }
    }
    

}

