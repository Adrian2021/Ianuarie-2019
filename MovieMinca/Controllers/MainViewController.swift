//
//  ViewController.swift
//  MovieMinca
//
//  Created by Adi on 25/10/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upcomingMoviesButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UIScreen.main.bounds.height <= DeviceModel.iPhone5.screenSize.height {
            setupForSmallScreen()
        }
    }
    
    private func setupForSmallScreen() {
        
        //
    }


}

