//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Isaias Suarez on 1/18/16.
//  Copyright © 2016 Isaias Suarez. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [NSDictionary]?
    var filteredMovies: [NSDictionary]?
    var endpoint: String!
    var selectedIndex: NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.dataSource = self
        //tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        //tableView.insertSubview(refreshControl, atIndex: 0)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        collectionView.alwaysBounceVertical = true
        
        networkRequest(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        for indexPath in collectionView.indexPathsForSelectedItems() ?? [] {
            collectionView.deselectItemAtIndexPath(indexPath, animated: animated)
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MovieCollectionViewCell
            cell.layer.borderWidth = 0.0
            //cell.layer.borderColor = UIColor.clearColor().CGColor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func networkRequest(initialLoad: Bool) {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        if initialLoad {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if initialLoad {
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                }
                if response != nil {
                    self.networkErrorView.hidden = true
                } else {
                    self.networkErrorView.hidden = false
                }
                
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //print("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.filteredMovies = self.movies
                            //self.tableView.reloadData()
                            self.collectionView.reloadData()
                    }
                }
        });
        
        task.resume()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        networkRequest(false)
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = filteredMovies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        if let posterPath = movie["poster_path"] as? String {
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            let imageRequest = NSURLRequest(URL: NSURL(string: baseUrl + posterPath)!)
            cell.posterView.setImageWithURLRequest(imageRequest, placeholderImage: nil, success: {(imageRequest, imageResponse, image) -> Void in
                if imageResponse != nil {
                    print("Image not cached, fade in image")
                    cell.posterView.alpha = 0.0
                    cell.posterView.image = image
                    UIView.animateWithDuration(0.3, animations: {() -> Void in
                        cell.posterView.alpha = 1.0
                    })
                } else {
                    print("Image was cached")
                    cell.posterView.image = image
                }
            },
            failure: {(imageRequest, imageResponse, error) -> Void in
                cell.posterView.image = nil
            })
        }
        else {
            cell.posterView.image = nil
        }
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        //print("row \(indexPath.row)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = filteredMovies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCollectionCell", forIndexPath: indexPath) as! MovieCollectionViewCell
        
        let movie = filteredMovies![indexPath.row]
        let title = movie["title"] as! String
        
        cell.movieTitle.text = title
        
        if let posterPath = movie["poster_path"] as? String {
            let smallUrl = "http://image.tmdb.org/t/p/w45"
            let largeUrl = "http://image.tmdb.org/t/p/original"
            let smallRequest = NSURLRequest(URL: NSURL(string: smallUrl + posterPath)!)
            let largeRequest = NSURLRequest(URL: NSURL(string: largeUrl + posterPath)!)
            
            cell.posterImage.setImageWithURLRequest(smallRequest, placeholderImage: nil, success: {(smallRequest, smallResponse, smallImage) -> Void in
                if smallResponse != nil {
                    print("Image not cached, fade in image")
                    cell.posterImage.alpha = 0.0
                    cell.posterImage.image = smallImage
                    UIView.animateWithDuration(0.3, animations: {() -> Void in
                        cell.posterImage.alpha = 1.0
                        }, completion: { (success) -> Void in
                            cell.posterImage.setImageWithURLRequest(largeRequest, placeholderImage: smallImage,
                                success: {(largeRequest, largeResponse, largeImage) -> Void in
                                    print("loading large image")
                                    cell.posterImage.image = largeImage
                                },
                                failure: { (request, response, error) -> Void in
                                    print("problems happened")
                                    cell.posterImage.image = smallImage
                                })
                    })
                } else {
                    print("Image was cached")
                    cell.posterImage.setImageWithURLRequest(largeRequest, placeholderImage: smallImage,
                        success: {(largeRequest, largeResponse, largeImage) -> Void in
                            cell.posterImage.image = largeImage
                        },
                        failure: { (request, response, error) -> Void in
                            cell.posterImage.image = nil
                            cell.movieTitle.hidden = false
                        })
                }
            },
            failure: {(imageRequest, imageResponse, error) -> Void in
                cell.posterImage.image = nil
                cell.movieTitle.hidden = false
            })
        }
        else {
            cell.posterImage.image = nil
            cell.movieTitle.hidden = false
        }

        /*
        if let posterPath = movie["poster_path"] as? String {
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            let imageUrl = NSURL(string: baseUrl + posterPath)
            cell.posterImage.setImageWithURL(imageUrl!)
        }
        else {
            cell.posterImage.image = nil
            cell.movieTitle.hidden = false
        }*/
        
        //print("row \(indexPath.row)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MovieCollectionViewCell
        cell.layer.borderWidth = 5.0
        cell.layer.borderColor = UIColor.blueColor().CGColor
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies?.filter({(dataItem: NSDictionary) -> Bool in
                if let title = dataItem["title"] as? String {
                    if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                        return true
                    } else {
                        return false
                    }
                }
                return false
            })
        }
        collectionView.reloadData()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true) //this doesn't seem to work?
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movie = movie
        selectedIndex = indexPath
    }
    

}
