//
//  AddMovieViewController.swift
//  MovieMinca
//
//  Created by Adi on 25/10/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import UIKit
import RealmSwift

class AddMovieViewController:
    UIViewController,
    UITextFieldDelegate,
    UITextViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    //MARK: - Outlets
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var movieDetailsView: UIView!
    @IBOutlet weak var moviePosterView: UIView!
    @IBOutlet weak var addMovieButton: UIButton!
    
    @IBOutlet weak var originalTitleValueTextField: UITextField!
    @IBOutlet weak var movieOverviewValueTextView: UITextView!
    
    @IBOutlet weak var imdbIdValueTextField: UITextField!
    
    
    @IBOutlet weak var navigationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieDetailsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var moviePosterHeightConstraints: NSLayoutConstraint!
    
    
    @IBOutlet weak var moviePosterLabel: UILabel!
    
    @IBOutlet weak var addMovieButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var originalTitleValueTextFieldHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imdbIdValueTextFieldHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movieOverviewValueTextFieldHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movieTitleLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addMovieButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieDetailsTopConstraint: NSLayoutConstraint!
    
    
    //MARK: - Actions
    @IBAction func backButtonAddMovie(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func onSelectFilesButtonClick(_ sender: Any) {
        
        if  UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            let cameraConter = UIImagePickerController()
            cameraConter.sourceType = UIImagePickerController.SourceType.camera
            cameraConter.delegate = self
            
            self.present(cameraConter, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let imageY = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        
      //  movie.imagePiker = imageY!.pngData() as! NSData
        
         movie.imagePiker = imageY!.jpegData(compressionQuality: 1.0) as! NSData
       
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    

    
    @IBAction func onAddMovieButtonClick(_ sender: UIButton) {
        
       
            movie.title = originalTitleValueTextField.text ?? "-"
            movie.shortDescription = movieOverviewValueTextView.text ?? "-"
            
            movie.customId2 = Int(imdbIdValueTextField.text ?? "") ?? 0
        
            movie.id = 335983
        
         //   movie.posterPath = ...??
            
        
        
        
        try! self.realm.write {
            self.realm.add(movie)
            
        }
        
        
            self.dismiss(animated: true, completion: nil)
            // let vc = storyboard.instantiate ()...
            // vc.movieTableView.reloadData
            //navigationController?.popToViewController(vc, animated: true)

    }
    
    
    var movie = Movie()
    var realm : Realm!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        RoundedCorners.make(for: navigationView, byRoundingCorners: [.bottomLeft,.bottomRight], withCornerRadius: 25)
        movieDetailsView.layer.cornerRadius = 10
        moviePosterView.layer.cornerRadius = 10
        movieOverviewValueTextView.layer.borderColor = UIColor.black.cgColor
        movieOverviewValueTextView.layer.borderWidth = 1
        addMovieButton.layer.cornerRadius = 5
        
        
        originalTitleValueTextField.delegate = self
        movieOverviewValueTextView.delegate = self
        imdbIdValueTextField.delegate = self
        
        realm = try! Realm()
        
        
        if UIScreen.main.bounds.height <= DeviceModel.iPhone5.screenSize.height {
            setupForSmallScreen()
        }
        
    }
    
    private func setupForSmallScreen() {
    
        navigationViewHeightConstraint.constant = navigationViewHeightConstraint.constant * 0.8
    
        movieDetailsViewHeightConstraint.constant = movieDetailsViewHeightConstraint.constant * 0.7
        
        moviePosterHeightConstraints.constant = moviePosterHeightConstraints.constant * 0.8
        
        if let font = moviePosterLabel.font {
            moviePosterLabel.font = font.withSize(12)
        }
        
        addMovieButtonTopConstraint.constant = 10
        
        originalTitleValueTextFieldHeightConstraint.constant = 30
        imdbIdValueTextFieldHeightConstraint.constant = 30
        movieOverviewValueTextFieldHeightConstraint.constant = 50
        
        movieTitleLabelHeightConstraint.constant = 22
        
        addMovieButtonHeightConstraint.constant = 45
        movieDetailsTopConstraint.constant = 12
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    
    
}
