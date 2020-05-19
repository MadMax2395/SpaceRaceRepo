//
//  Character.swift
//  SpaceRace
//
//  Created by fernando rosa on 24/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import Foundation

class Character{
    var name:String
    var image:String
    var description:String
    var imageDetail:String
    var unlocked:Bool
    
    init() {
        self.name = ""
        self.image = ""
        self.description = ""
        self.imageDetail = ""
        self.unlocked = false
    }
    
    init(name:String, image:String, description:String, imageDetail:String) {
        self.name = name
        self.image = image
        self.description = description
        self.imageDetail = imageDetail
        self.unlocked = false
    }
}
