//
//  ResourceManager.swift
//  SpaceRace
//
//  Created by fernando rosa on 07/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//



import Foundation

class ResourceManager {
    
    static let shared = ResourceManager()
    private init(){}
    
    func loadUserSettings() -> NSDictionary?{
        let localpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("UserSettings.plist")
        if(!FileManager.default.fileExists(atPath: localpath.relativePath)){
            if let path = Bundle.main.path(forResource: "UserSettings", ofType: "plist") {
                var nsDictionary:[String : Any] = NSDictionary(contentsOfFile: path) as! [String : Any]
                do  {
                let data = try PropertyListSerialization.data(fromPropertyList: nsDictionary, format: PropertyListSerialization.PropertyListFormat.binary, options: 0)
                    do {
                     try data.write(to: localpath , options: .atomic)
                        print("Successfully write")
                        return nsDictionary as! NSDictionary
                    }catch (let err){
                        print(err.localizedDescription)
                        return nil
                    }
                }catch (let err){
                    print(err.localizedDescription)
                    return nil
                }
            }
        }
        else
        {
            return NSDictionary(contentsOfFile: localpath.relativePath)!
        }
        return nil
    }
    
    func loadLevelData(level:Int) -> NSDictionary?{
        if let path = Bundle.main.path(forResource: "Malus", ofType: "plist") {
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            let leveDict:NSDictionary = dict.value(forKey: "Level\(level)") as! NSDictionary
            return leveDict
        }
        else
        {
            return nil
        }
    }
    
    func loadPlanetsData() -> NSDictionary?{
        if let path = Bundle.main.path(forResource: "Planets", ofType: "plist") {
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            return dict
        }
        else
        {
            return nil
        }
    }
    
    func loadGalleryData() -> NSDictionary?{
        if let path = Bundle.main.path(forResource: "Gallery", ofType: "plist") {
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            return dict
        }
        else
        {
            return nil
        }
    }
    
    func loadLevelPlayer(level:Int) -> NSDictionary?{
        if let path = Bundle.main.path(forResource: "Player", ofType: "plist") {
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            let leveDict:NSDictionary = dict.value(forKey: "Level\(level)") as! NSDictionary
            return leveDict
        }
        else
        {
            return nil
        }
    }
    
    func loadLevelSpaceJunk(type: String) -> NSDictionary?{
        if let path = Bundle.main.path(forResource: "SpaceJunk", ofType: "plist") {
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            let leveDict:NSDictionary = dict.value(forKey: "\(type)") as! NSDictionary
            return leveDict
        }
        else
        {
            return nil
        }
    }
    
    
    
    func loadLevelItem(level: Int) -> NSDictionary?{
        if let path = Bundle.main.path(forResource: "Item", ofType: "plist") {
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            let leveDict:NSDictionary = dict.value(forKey: "\(level)") as! NSDictionary
            return leveDict
        }
        else
        {
            return nil
        }
    }
    
    func loadLevelBonus(type: String) -> NSDictionary?{
        if let path = Bundle.main.path(forResource: "Bonus", ofType: "plist") {
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            let leveDict:NSDictionary = dict.value(forKey: "\(type)") as! NSDictionary
            return leveDict
        }
        else
        {
            return nil
        }
    }
    
   
    func saveUserSettings() -> Bool{
        let localpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("UserSettings.plist")
        
         var nsDictionary:[String : Any] = NSDictionary(contentsOfFile: localpath.relativePath) as! [String : Any]
           nsDictionary["useSoundEffetcs"] = GameManager.shared.isSoundEffetsEnabled()
           nsDictionary["useMusic"] = GameManager.shared.isMusicEnabled()
           nsDictionary["useTouch"] = GameManager.shared.isTouchEnabled()
           nsDictionary["useTutorial"] = GameManager.shared.isTutorialEnabled()
           nsDictionary["useMenuMusic"] = GameManager.shared.isMenuMusicEnabled()
           guard FileManager.default.fileExists(atPath: localpath.relativePath) else {
               return false
           }
           do  {
           let data = try PropertyListSerialization.data(fromPropertyList: nsDictionary, format: PropertyListSerialization.PropertyListFormat.binary, options: 0)
               do {
                try data.write(to: localpath , options: .atomic)
                   print("Successfully write")
                   return true
               }catch (let err){
                   print(err.localizedDescription)
                   return false
               }
           }catch (let err){
               print(err.localizedDescription)
               return false
           }
        
    }

}
