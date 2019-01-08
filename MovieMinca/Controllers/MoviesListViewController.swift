//
//  HomeViewController.swift
//  MovieMinca
//
//  Created by Adi on 25/10/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import Kingfisher
import RealmTypeSafeQuery


class MoviesListViewController:
        UIViewController,
        UISearchBarDelegate
    
{

    // MARK: - Outlets
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var navigationViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var filtersButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchBarViewHeightConstraint: NSLayoutConstraint!
    
    
    
    // MARK: - Actions
    @IBAction func onBackButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onFiltersButtonClick(_ sender: UIButton) {
       
        
        if filters{
            
            filters = false
            
            searching = false
            searchBar.text = ""
            movieTableView.reloadData()
            searchLabel.text = "\(movieArray.count) " + "Movies based on your search"

            view.endEditing(true)
            
        }
        else {
            
            filters = true
            
            searching = true
            movieTableView.reloadData()
            searchLabel.text = "\(movieSearchArray.count) " + "Movies based on your search"
            
            view.endEditing(true)
        
        }
    }
    
    var movieArray : Results<Movie>!
    var movieSearchArray = [Movie]()
    var searchTerm  = ""
    var searching = false
    var filters  = false
    
    
    
    private let dateFormatter : DateFormatter = DateFormatter()
    
    var movie : Movie!
    var realm : Realm!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        getUpcomingMovies()
        setupDateFormatter()
        searchBarView.layer.cornerRadius = 16
        RoundedCorners.make(for: navigationView, byRoundingCorners: [.bottomLeft, .bottomRight], withCornerRadius: 25)
        
        
        self.realm = try! Realm()
        movieArray = realm.objects(Movie.self)
    
        
        if UIScreen.main.bounds.height <= DeviceModel.iPhone5.screenSize.height {
            setupForSmallScreen()
        }
    
    
   
    }


    private func setupForSmallScreen() {
        
        navigationViewHeightConstraint.constant = 100
        searchBarHeightConstraint.constant = 40
        filtersButtonHeightConstraint.constant = 40
        searchBarViewHeightConstraint.constant = 40
        
    }
    // Networking with Alamofire:
    
    private func getUpcomingMovies(){
        
        let parameters: Parameters = ["api_key": NetworkManager.apiKey]
        Alamofire.request(NetworkManager.baseUrl + "movie/upcoming", parameters: parameters).responseJSON { json in
            let responseJson = try! JSONSerialization.jsonObject(with: json.data!) as? [String:Any]
            guard let response = responseJson else { return }
            let results = response["results"] as! [[String: Any]]
            for movie in results {
                let movie = Movie(localId: UUID().uuidString, customId2: 0, id: movie["id"] as! Int, title: movie["title"] as! String, date: movie["release_date"] as! String, shortDescription: movie["overview"] as! String, posterPath: "https://image.tmdb.org/t/p/w400/\(movie["poster_path"] as! String)", backdrop_path: "https://image.tmdb.org/t/p/w400/\(movie["backdrop_path"] as? String ?? "")", imagePiker: nil)
                //
                if let existingMovie = self.realm.objects(Movie.self).filter(\Movie.id == movie.id).first {
                    try! self.realm.write {
                        self.realm.delete(existingMovie)
                    }
                }
                
                 try! self.realm.write {
                    self.realm.add(movie)
              
                 }
                
             }
            self.movieTableView.reloadData()
        }

     }
    
    private func setupDateFormatter() {
        dateFormatter.dateFormat = "MMMM dd, yyyy"
    }
    
    // hide keyboard when touch outside the searchBar
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
   
  
    
    //MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(self.search),
            object: nil)

        searchTerm = searchText
        self.perform(#selector(self.search), with: nil, afterDelay: 0.5)
    }

    
    @objc func search(){
        searchResults()
    

    }
    
    private func searchResults(){

        let results = realm.objects(Movie.self).filter{($0.title.prefix(self.searchTerm.count) == self.searchTerm)}

        movieSearchArray = Array(results)
        
        searchLabel.text = "\(movieSearchArray.count) " + "Movies based on your search"
   
        searching = true
        movieTableView.reloadData()
    
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchLabel.text = ""
    }
    
    
    
  
    
}





extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        if searching {
            return movieSearchArray.count
        }
        else {
            return movieArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell" ) as! MovieTableViewCell
        
        
        if searching {
             movie = movieSearchArray[indexPath.row]
        }
        else{
             movie = movieArray[indexPath.row]
        }
        
        cell.movieTitleLabel.text = movie.title

        let dateFromString = dateFormatter.date(from: movie.date)
        
        cell.dateLabel.text = dateFormatter.string(from: dateFromString ?? Date())
        
        cell.descriptionLabel.text = movie.shortDescription
       
        if let imageX = movie.imagePiker {
            
        cell.posterImageView.image = UIImage(data: imageX as Data)
            
        } else {
        
        cell.posterImageView.kf.setImage(with: URL(string: movie.posterPath))
        
        }
        
        cell.imageCircleView.kf.setImage(with: URL(string: movie.backdrop_path))
        cell.selectionStyle = .none
        
        return cell
    }
}




extension MoviesListViewController :  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if searching {
            movie = movieSearchArray[indexPath.row]
        }
        else{
            movie = movieArray[indexPath.row]
        }
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        vc.loadViewIfNeeded()
        
        vc.movieTitleLabel.text = movie.title
        vc.movieDateLabel.text = movie.date
        vc.movieDescriptionLabel.text = movie.shortDescription
      
        
        
        if let imageX = movie.imagePiker {
            
           vc.movieImageView.image = UIImage(data: imageX as Data)
            
        } else {
            
           vc.movieImageView.kf.setImage(with: URL(string: movie.posterPath))
            
        }
        
        
      
        
        vc.id2 = movie.id
        
        vc.addMovieCustomId = movie.customId2
    
        self.present(vc, animated: true)
    
        
            
    }
    
}
