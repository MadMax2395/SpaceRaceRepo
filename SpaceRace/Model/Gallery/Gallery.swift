//
//  Gallery.swift
//  SpaceRace
//
//  Created by fernando rosa on 24/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import Foundation

class Gallery{
    var specialObjects:[SpecialObject]
    var characters:[Character]
    
    init() {
        self.specialObjects = [SpecialObject]()
        self.characters = [Character]()
    }
    
    init(charactersDict:NSDictionary, specialObjectsDict:NSDictionary) {
        self.specialObjects = [SpecialObject]()
        self.characters = [Character]()
        for index in 0..<charactersDict.count{
            let character = Character(name: (charactersDict.value(forKey: "Character\(index+1)") as! NSDictionary).value(forKey: "name") as! String, image: (charactersDict.value(forKey: "Character\(index+1)") as! NSDictionary).value(forKey: "image") as! String, description: (charactersDict.value(forKey: "Character\(index+1)") as! NSDictionary).value(forKey: "description") as! String, imageDetail: (charactersDict.value(forKey: "Character\(index+1)") as! NSDictionary).value(forKey: "imageDetail") as! String)
            self.characters.append(character)
        }
        for index in 0..<specialObjectsDict.count{
            let so = SpecialObject(name: (specialObjectsDict.value(forKey: "SpecialObject\(index+1)") as! NSDictionary).value(forKey: "name") as! String, image: (specialObjectsDict.value(forKey: "SpecialObject\(index+1)") as! NSDictionary).value(forKey: "image") as! String, description: (specialObjectsDict.value(forKey: "SpecialObject\(index+1)") as! NSDictionary).value(forKey: "description") as! String)
            self.specialObjects.append(so)
        }
        print()
    }
}

