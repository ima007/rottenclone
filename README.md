## Rotten Tomatoes

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: 10hrs on core, 6hrs on optional (a little more time than necessary on reseaching stuff)

### Features

#### Required

- [X] User can view a list of movies. Poster images load asynchronously.
- [X] User can view movie details by tapping on a cell.
- [X] User sees loading state while waiting for the API.
- [X] User sees error message when there is a network error (mine programatically moves the view into the navigation bar controller, so it's fixed)
- [X] User can pull to refresh the movie list. (Note: I made it choose a random sublist)

#### Optional

- [X] All images fade in.
- [X] For the larger poster, load the low-res first and switch to high-res when complete.
- [X] All images should be cached in memory and disk
- [ ] Implement segmented control to switch between list view and grid view. Hint: The segmented control should hide/show a UITableView and a UICollectionView
- [X] Customize the highlight and selection effect of the cell.
- [X] Customize the navigation bar.
- [X] Add a tab bar for Box Office and DVD.
- [X] Add a search bar: pretty simple implementation of searching against the existing table view data.

### Walkthrough

[gfycat link](http://gfycat.com/WanGrossHairstreakbutterfly)

#### Screenshot of error message
![Screenshot of error message](error.png|width=350px)

#### GIF (kinda large)
![Video Walkthrough](rottendemo.gif|width=350px)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [JSONHelper](https://github.com/isair/JSONHelper)
* [SVProgressHUD](https://github.com/TransitApp/SVProgressHUD)
