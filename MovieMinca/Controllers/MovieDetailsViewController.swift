//
//  MovieDetailsViewController.swift
//  MovieMinca
//
//  Created by Adi on 25/10/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import RealmTypeSafeQuery
import Kingfisher


class MovieDetailsViewController:
    UIViewController

{

    //MARK: - Outlets
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    @IBOutlet weak var actor1ImageView: UIImageView!
    @IBOutlet weak var actor2ImageView: UIImageView!
    @IBOutlet weak var actor3ImageView: UIImageView!
    @IBOutlet weak var actor4ImageView: UIImageView!
    
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var featuredCrewView: UIView!
    @IBOutlet weak var topBilledCastView: UIView!
    
     //MARK: Crew Names
    @IBOutlet weak var character1Label: UILabel!
    @IBOutlet weak var character2Label: UILabel!
    @IBOutlet weak var character3Label: UILabel!
    @IBOutlet weak var screenPlay1Label: UILabel!
    @IBOutlet weak var screenPlay2Label: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    
     //MARK: Crew Jobs
    
    
    @IBOutlet weak var character1Job: UILabel!
    @IBOutlet weak var character2Job: UILabel!
    @IBOutlet weak var character3Job: UILabel!
    @IBOutlet weak var screenPlayJob1: UILabel!
    @IBOutlet weak var screenPlayJob2: UILabel!
    
    @IBOutlet weak var directorJobLabel: UILabel!
    
    @IBOutlet weak var featuredCrewLabel: UILabel!
    
    
    @IBOutlet weak var navigationViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var overviewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var featuredCrewViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBilledCastViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movieImageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var circleImageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movieImageViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movieImageViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movieImageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var overviewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var featuredCrewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topBilledCastBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
  
    @IBOutlet var actorsWidthConstraints: [NSLayoutConstraint]!
    @IBOutlet var actorsHeightConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var stack5TopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var topBilledCastLabel: UILabel!
    
    @IBOutlet weak var actorsStackView: UIStackView!
    
    @IBOutlet weak var topBilledCastLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewCrew1: UIStackView!
    @IBOutlet weak var stackViewCrew2: UIStackView!
    
    @IBOutlet weak var stackViewCrew3: UIStackView!
    @IBOutlet weak var stackViewCrew4: UIStackView!
    
    @IBOutlet weak var stackViewCrew5: UIStackView!
    @IBOutlet weak var stackViewCrew6: UIStackView!
    

    
    //MARK: Actions
    @IBAction func onBackButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var realm: Realm!
    var movieDetails = MovieDetails()
    
    var id2 = Int()
    
    var addMovieCustomId = Int()
    
    
    var screenPlayArray = [String]()
    var characterArray = [String]()
    
    
    var screenJobArray1 = [String]()
    var characterJobArray1 = [String]()
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RoundedCorners.make(for: navigationView, byRoundingCorners: [.bottomLeft, .bottomRight], withCornerRadius: 25)
        overviewView.layer.cornerRadius = 10
        featuredCrewView.layer.cornerRadius = 10
        topBilledCastView.layer.cornerRadius = 10
        
        realm = try! Realm()
        
        
        if UIScreen.main.bounds.height <= DeviceModel.iPhone5.screenSize.height {
            setupForSmallScreen()
        }
       
     }
    
    private func setupForSmallScreen() {
        
        navigationViewHeightConstraint.constant =   navigationViewHeightConstraint.constant * 0.8
     
        overviewHeightConstraint.constant = overviewHeightConstraint.constant * 0.7
        
        featuredCrewViewHeightConstraint.constant = featuredCrewViewHeightConstraint.constant * 0.8
        
        topBilledCastViewHeightConstraint.constant = topBilledCastViewHeightConstraint.constant * 0.8
        
        circleImageViewTopConstraint.constant = 4
        movieImageViewTopConstraint.constant = 26
        
        backButtonTopConstraint.constant = 15
        
        if let font = movieTitleLabel.font {
            movieTitleLabel.font = font.withSize(14)
        }
        
        if let font = movieDateLabel.font {
            movieDateLabel.font = font.withSize(10)
        }
        movieImageViewTrailingConstraint.constant = 20
        
        movieImageViewWidthConstraint.constant = 80
        movieImageViewHeightConstraint.constant = 120
        
        overviewBottomConstraint.constant = 8
        featuredCrewBottomConstraint.constant = 8
        
        stackViewTopConstraint.constant = 10
        
        for constraint in actorsWidthConstraints {
            constraint.constant = 54
        }
        
        for constraint in actorsHeightConstraints {
            constraint.constant = 64
        }
        
        if let font = movieDescriptionLabel.font {
            movieDescriptionLabel.font = font.withSize(12)
        }
        if let font = overviewLabel.font {
            overviewLabel.font = font.withSize(13)
        }
        
        if let font = featuredCrewLabel.font {
            featuredCrewLabel.font = font.withSize(13)
        }
        
        stack5TopConstraint.constant = 4
        
        if let font = topBilledCastLabel.font {
            topBilledCastLabel.font = font.withSize(13)
        }
        
        actorsStackView.spacing = 8
        topBilledCastLabelHeightConstraint.constant = 20
        
        stackViewCrew1.spacing = 4
        stackViewCrew2.spacing = 4
        stackViewCrew3.spacing = 4
        stackViewCrew4.spacing = 4
        stackViewCrew5.spacing = 4
        stackViewCrew6.spacing = 4
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getMovieCast()
        
        getMovieCrew()
        
    }
    
    
  
    
    
    
    
    private func getMovieCast() {
        let parameters: Parameters = ["api_key": NetworkManager.apiKey]
        Alamofire.request(NetworkManager.baseUrl + "movie/\(id2)/credits", method:.get, parameters: parameters).responseJSON { json in
            let responseJson = try! JSONSerialization.jsonObject(with: json.data!) as? [String:Any]
            
            print(json)
            guard let response = responseJson else { return }
            let cast = responseJson!["cast"] as? [[String: Any]] ?? [["":""]]
            
        
                let m1 = (cast[0] as? [String: Any]) ?? ["":""]
                let m2 = (cast[1] as? [String: Any]) ?? ["":""]
                let m3 = (cast[2] as? [String: Any]) ?? ["":""]
                let m4 = (cast[3] as? [String: Any]) ?? ["":""]
            
            
            let movieD = MovieDetails(localId: UUID().uuidString, id: self.movieDetails.id, actor1: "https://image.tmdb.org/t/p/w400/\(m1["profile_path"] as? String ?? "")", actor2: "https://image.tmdb.org/t/p/w400/\(m2["profile_path"] as? String ?? "")", actor3: "https://image.tmdb.org/t/p/w400/\(m3["profile_path"] as? String ?? "")", actor4: "https://image.tmdb.org/t/p/w400/\(m4["profile_path"] as? String ?? "")")
            
            
            if let existingMovieD = self.realm.objects(MovieDetails.self).filter(\MovieDetails.id == movieD.id).first {
                    try! self.realm.write {
                        self.realm.delete(existingMovieD)
                    }
                }
                
                try! self.realm.write {
                    self.realm.add(movieD)
                    
                }
                
                self.actor1ImageView.kf.setImage(with: URL(string: movieD.actor1))
                self.actor2ImageView.kf.setImage(with: URL(string: movieD.actor2))
                self.actor3ImageView.kf.setImage(with: URL(string: movieD.actor3))
                self.actor4ImageView.kf.setImage(with: URL(string: movieD.actor4))
         
    
        }
    }

    
    
    
    private func getMovieCrew() {
        let parameters: Parameters = ["api_key": NetworkManager.apiKey]
        Alamofire.request(NetworkManager.baseUrl + "movie/\(id2)/credits", method:.get, parameters: parameters).responseJSON { json in
            let responseJson = try! JSONSerialization.jsonObject(with: json.data!) as? [String:Any]
            
            print(json)
            guard let response = responseJson else { return }
           
            let crew = responseJson!["crew"] as? [[String: Any]] ?? [["":""]]
            
            var mov1 = crew[safe: 0]
            var mov2 = crew[safe: 1]
            var mov3 = crew[safe: 2]
            var mov4 = crew[safe: 3]
            var mov5 = crew[safe: 4]
            
            for movie2 in crew {
           
            
            let movieCrew = MovieCrew(localId: UUID().uuidString, id: self.movieDetails.id, job: movie2["job"] as? String ?? "" , name: movie2["name"] as? String ?? "")
            
            if let existingMovieCrew = self.realm.objects(MovieDetails.self).filter(\MovieDetails.id == movieCrew.id).first {
                try! self.realm.write {
                    self.realm.delete(existingMovieCrew)
                }
            }
            
            try! self.realm.write {
                self.realm.add(movieCrew)
                
            }
            
                
                
                if movieCrew.job != (mov1?["job"] as! String) && movieCrew.job != (mov2?["job"] as! String) && movieCrew.job != (mov3?["job"] as! String) && movieCrew.job != (mov4?["job"] as! String) &&  movieCrew.job != (mov5?["job"] as! String) {
                
                
                if movieCrew.job == "Screenplay" {
                    
                   self.screenPlayArray.append(movieCrew.name)
                    
                    self.screenJobArray1.append(movieCrew.job)
                
                }
                
                
                if movieCrew.job == "Characters" {
                    
                    self.characterArray.append(movieCrew.name)
                    
                    self.characterJobArray1.append(movieCrew.job)
            
                }
                    
          }
                
                
                if movieCrew.job == "Director" {
                    
                    
                    self.directorLabel.text = movieCrew.name ?? "-"
                    
              
                         }
                  }
            
            
            var mov11 = String()
            var mov12 = String()
            var mov13 = String()
            var mov14 = String()
            var mov15 = String()
            
            var mov21 = String()
            var mov22 = String()
            var mov23 = String()
            var mov24 = String()
            var mov25 = String()
            
            
            if (mov1?["job"] as? String ?? "") != "Director" {
            
                mov11 = (mov1?["name"] as? String ?? "")
                mov21 = (mov1?["job"] as? String ?? "")
                
            } else {
                
                mov11 = " "
                mov21 = " "
                
            }
            
            if (mov2?["job"] as? String ?? "") != "Director" {
                
                mov12 = (mov2?["name"] as? String ?? "")
                mov22 = (mov2?["job"] as? String ?? "")
                
            } else {
                
                mov12 = " "
                mov22 = " "
                
            }
            
            if (mov3?["job"] as? String ?? "") != "Director" {
                
                mov13 = (mov3?["name"] as? String ?? "")
                mov23 = (mov3?["job"] as? String ?? "")
                
                
            } else {
                
                mov13 = " "
                mov23 = " "
                
            }
            
            if (mov4?["job"] as? String ?? "") != "Director" {
                
                mov14 = (mov4?["name"] as? String ?? "")
                mov24 = (mov4?["job"] as? String ?? "")
                
            } else {
                
                mov14 = " "
                mov24 = " "
                
            }
            
            if (mov5?["job"] as? String ?? "") != "Director" {
                
                mov15 = (mov5?["name"] as? String ?? "")
                mov25 = (mov5?["job"] as? String ?? "")
            } else {
                
                mov15 = " "
                mov25 = " "
                
            }
            
//             self.screenPlay1Label.text = self.screenPlayArray[safe: 0] ?? (mov1?["name"] as? String ?? "")

            self.screenPlay1Label.text = self.screenPlayArray[safe: 0] ?? mov11
            self.screenPlay2Label.text = self.screenPlayArray[safe: 1] ?? mov12
            
          
            self.character1Label.text = self.characterArray[safe: 0] ??  mov13
            self.character2Label.text = self.characterArray[safe: 1] ??  mov14
            self.character3Label.text = self.characterArray[safe: 2] ??  mov15
            
            
            //...CREW JOBS:
        
//             self.screenPlayJob1.text = self.screenJobArray1[safe: 0] ?? (mov1?["job"] as? String ?? "")
            
            self.screenPlayJob1.text = self.screenJobArray1[safe: 0] ?? mov21
            self.screenPlayJob2.text = self.screenJobArray1[safe: 1] ?? mov22
            self.character1Job.text = self.characterJobArray1[safe: 0] ?? mov23
            self.character2Job.text = self.characterJobArray1[safe: 1] ?? mov24
            self.character3Job.text = self.characterJobArray1[safe: 2] ?? mov25
            
            
            
            if self.addMovieCustomId != 0 {
                
                self.screenPlay1Label.text = "-"
                self.screenPlay2Label.text = "-"
                
                self.character1Label.text = "-"
                self.character2Label.text = "-"
                self.character3Label.text = "-"
                
                self.directorLabel.text = "Unknown"
                //...CREW JOBS:
                
                self.screenPlayJob1.text = "ScreenPlay"
                self.screenPlayJob2.text = "ScreenPlay"
                self.character1Job.text = "Character"
                self.character2Job.text = "Character"
                self.character3Job.text = "Character"
                
                
                // TOP Billed Cast Images:
        
                   self.actor1ImageView.image = UIImage(named: "Unknown")
                   self.actor2ImageView.image = UIImage(named: "Unknown")
                   self.actor3ImageView.image = UIImage(named: "Unknown")
                   self.actor4ImageView.image = UIImage(named: "Unknown")

                
            }
        }
    }
    
}


extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
