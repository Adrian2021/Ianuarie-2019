//
//  MovieCrew.swift
//  MovieMinca
//
//  Created by Adi on 01/11/2018.
//  Copyright © 2018 Adrian-Minca. All rights reserved.
//

import Foundation
import RealmSwift

class MovieCrew: Object {
    
    @objc dynamic var localId = UUID().uuidString
    @objc dynamic var id : Int = 0
    
    @objc dynamic var job : String = ""
    @objc dynamic var name : String = ""
    
    
   
    
    
    override class func primaryKey() -> String? {
        return "localId"
    }
    
    convenience init (localId: String, id: Int, job : String, name: String) {
        self.init()
        
        self.localId = localId
        self.id = id
        
        self.job = job
        self.name = name
        
    }
    
}
