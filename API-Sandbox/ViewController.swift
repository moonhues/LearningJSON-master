//
//  ViewController.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ViewController: UIViewController {
  

  @IBOutlet weak var movieTitleLabel: UILabel!
  @IBOutlet weak var rightsOwnerLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  var displayMovie: Movie?
  var topMovies: [Movie]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
            exerciseOne()
    //        exerciseTwo()
    //        exerciseThree()
    
    let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    // This code will call the iTunes top 25 movies endpoint listed above
    Alamofire.request(.GET, apiToContact).validate().responseJSON() { response in
      switch response.result {
      case .Success:
        if let value = response.result.value {
          let json = JSON(value)
          
          // Do what you need to with JSON here!
          // The rest is all boiler plate code you'll use for API requests
          
          print(json)
          
          self.topMovies = json["feed"]["entry"].arrayValue.map {
            Movie(json: $0)
          }
          
          self.displayRandomMovie()
          
        }
      case .Failure(let error):
        print(error)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Updates the image view when passed a url string
  func loadPoster(urlString: String) {
    
    posterImageView.af_setImageWithURL(NSURL(string: urlString)!)
  }
  
  @IBAction func viewOniTunesPressed(sender: AnyObject) {
    if let displayMovie = displayMovie{
      UIApplication.sharedApplication().openURL(NSURL(string: "\(displayMovie.link)")!)
    } else {
      print("Movie has not yet loaded")
    }
  }
  
  @IBAction func newMovie(sender: AnyObject) {
    displayRandomMovie()
  }
  
  func populateGUI(movie movie:Movie){
    movieTitleLabel.text = movie.name
    rightsOwnerLabel.text = movie.rightsOwner
    releaseDateLabel.text = movie.releaseDate
    priceLabel.text = "$\(movie.price)"
    loadPoster(movie.imageLoc)

  }
  
  func displayRandomMovie(){
    if let movies = topMovies{
      self.displayMovie = movies[Int(arc4random_uniform(UInt32(movies.count)))]
      self.populateGUI(movie: self.displayMovie!)
    } else {
      print("Movies have not yet been received from itunes")
    }
  }
  
}

