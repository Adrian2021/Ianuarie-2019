//
//  Movie.swift
//  MovieMinca
//
//  Created by Adi on 25/10/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import Foundation
import RealmSwift

class Movie : Object {
   @objc dynamic var localId = UUID().uuidString
    
    @objc dynamic var customId2 : Int = 0
    
    @objc dynamic var id : Int = 335983
    @objc dynamic var title: String = ""
    @objc dynamic var date : String = ""
    @objc dynamic var shortDescription : String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var backdrop_path: String = ""
   
    @objc dynamic var imagePiker: NSData? = nil
    
    override class func primaryKey() -> String? {
        return "localId"
    }
    
    convenience init (localId: String, customId2: Int, id: Int, title: String, date : String, shortDescription : String, posterPath: String, backdrop_path: String, imagePiker: NSData?) {
        self.init()
        
        self.localId = localId
        
        self.customId2 = customId2
        
        self.id = id
        self.title = title
        self.date = date
        self.shortDescription = shortDescription
        self.posterPath = posterPath
        self.backdrop_path = backdrop_path
        
        self.imagePiker = imagePiker
    }
    
}

// Primul Proiect

// A 2-a modificare


// FINALUL 
