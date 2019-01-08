//
//  MovieDetails.swift
//  MovieMinca
//
//  Created by Adi on 28/10/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import Foundation
import RealmSwift

class MovieDetails: Object {
   
    @objc dynamic var localId = UUID().uuidString
    
    @objc dynamic var id : Int = 0

  
    @objc dynamic var actor1 : String = ""
    @objc dynamic var actor2 : String = ""
    @objc dynamic var actor3 : String = ""
    @objc dynamic var actor4 : String = ""
    
    
    override class func primaryKey() -> String? {
        return "localId"
    }
    
    convenience init (localId: String, id: Int, actor1: String, actor2 : String, actor3: String, actor4: String) {
        self.init()
        
        self.localId = localId
        self.id = id
        
        self.actor1 = actor1
        self.actor2 = actor2
        self.actor3 = actor3
        self.actor4 = actor4
        
       
        
    }
    
}
