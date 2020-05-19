//
//  Planet.swift
//  SpaceRace
//
//  Created by fernando rosa on 21/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import Foundation

class Planet{
    var name:String
    var image:String
    var description:String
    var levels:[Level]
    
    init() {
        self.name = ""
        self.image = ""
        self.description = ""
        self.levels = [Level]()
    }
    
    init(name:String, image:String, description:String, numberOfMissions:Int, levels:NSDictionary) {
        self.name = name
        self.image = image
        self.description = description
        self.levels = [Level]()
        for index in 0..<numberOfMissions{
            self.levels.append(Level(number: index+1, mission: Mission(name: (levels.value(forKey: "level\(index+1)") as! NSDictionary).value(forKey: "missionName") as! String, characterName: (levels.value(forKey: "level\(index+1)") as! NSDictionary).value(forKey: "character") as! String)))
        }
    }
}
