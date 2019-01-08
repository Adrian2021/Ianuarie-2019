//
//  MovieTableViewCell.swift
//  MovieMinca
//
//  Created by Adi on 25/10/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageCircleView: UIImageView!

    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var posterImageViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageCircleViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dataViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dataViewTrailingConstraint: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dataView.layer.cornerRadius = 14
        
        if UIScreen.main.bounds.height <= DeviceModel.iPhone5.screenSize.height {
            setupForSmallScreen()
        }
        
    }
    
    private func setupForSmallScreen() {
        posterImageViewWidthConstraint.constant = 80
        
        if let font = dateLabel.font {
            dateLabel.font = font.withSize(10)
        }
        
        imageCircleViewWidthConstraint.constant = 40
        
        if let font = movieTitleLabel.font {
            movieTitleLabel.font = font.withSize(11)
        }
        
        dataViewLeadingConstraint.constant = 16
        dataViewTrailingConstraint.constant = 16
        
        if let font = descriptionLabel.font {
            descriptionLabel.font = font.withSize(10)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
