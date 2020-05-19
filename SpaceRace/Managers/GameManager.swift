//
//  GameManager.swift
//  SpaceRace
//
//  Created by fernando rosa on 07/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class GameManager {
    static let shared = GameManager()
    private var useTouch: Bool!
    private var useMusic: Bool!
    private var useMenuMusic:Bool!
    private var useTtutorial:Bool!
    private var useSoundEffetcs: Bool!
    
    private var dataCurrentLevel:NSDictionary!
    private var planetsData:NSDictionary!
    private var galleryData:NSDictionary!
    
    private init(){
        self.useTouch = true
        self.useMusic = true
        self.useSoundEffetcs = true
    }
    
    func isTouchEnabled() -> Bool{
        return self.useTouch
    }
    
    func isMusicEnabled() -> Bool{
        return self.useMusic
    }
    
    func isSoundEffetsEnabled() -> Bool{
        return self.useSoundEffetcs
    }
    
    func isMenuMusicEnabled() -> Bool{
        return self.useMenuMusic
    }
    
    func isTutorialEnabled() -> Bool{
        return self.useTtutorial
    }
    
    func setTouchEnabled(enabled:Bool){
        self.useTouch = enabled
    }
    
    func setMusicEnabled(enabled:Bool){
        self.useMusic = enabled
    }
    
    func setSoundEffetcsEnabled(enabled:Bool){
        self.useSoundEffetcs = enabled
    }
    
    func setMenuMusicEnabled(enabled:Bool){
        self.useMenuMusic = enabled
    }
    
    func setTutorialEnabled(enabled:Bool){
        self.useTtutorial = enabled
    }
    
    func setSettingsFromLocalData(useTouch:Bool, useMusic:Bool, useSoundEffetcs:Bool, useTutorial:Bool, useMenuMusic:Bool){
        self.useTouch = useTouch
        self.useMusic = useMusic
        self.useSoundEffetcs = useSoundEffetcs
        self.useTtutorial = useTutorial
        self.useMenuMusic = useMenuMusic
    }
    
    func setPlanetsData(data:NSDictionary){
        self.planetsData = data
    }
    
    func setGalleryData(data:NSDictionary){
        self.galleryData = data
    }
    
    func setDataCurrentLevel(data:NSDictionary){
        self.dataCurrentLevel = data
    }
    
    func setDataCurrentPlayer(data: NSDictionary){
        self.dataCurrentLevel = data
    }
    
    func getCurrentLevelSmallRocks() -> Bool{
        return (self.dataCurrentLevel.value(forKey: "small_rocks") != nil)
    }
    
    func getCurrentLevelBigRocks() -> Bool{
        return (self.dataCurrentLevel.value(forKey: "big_rocks") != nil)
    }
    
    func getCurrentLevelSmallJunks() -> Bool{
        return (self.dataCurrentLevel.value(forKey: "small_junk") != nil)
    }
    
    func getCurrentLevelBigJunks() -> Bool{
        return (self.dataCurrentLevel.value(forKey: "big_junk") != nil)
    }
    
    func getCurrentPlayerImage() -> String{
        return self.dataCurrentLevel.value(forKey: "imageName") as! String
    }
    
    func getCurrentPlayerImageUp() -> String{
        return self.dataCurrentLevel.value(forKey: "imageUp") as! String
    }
    
    func getCurrentPlayerImageDown() -> String{
        return self.dataCurrentLevel.value(forKey: "imageDown") as! String
    }
    
    func getCurrentPlayerMaxOxygen() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "maxOxygen") as! CGFloat
    }
    
    func getCurrentPlayerFuel() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "maxFuel") as! CGFloat
    }
    
    func getCurrentPlayerOxPerSec() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "oxygenPerSec") as! CGFloat
    }
    
    func getCurrentPlayerFuelPerSec() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "fuelPerSec") as! CGFloat
    }
    
    
    func getTypeSpaceJunk() -> String{
        return self.dataCurrentLevel.value(forKey: "type") as! String
    }
    
    func getMalusOxygen() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "malusOxygen") as! CGFloat
    }
    
    func getMalusOxygenPerSec() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "malusOxygenPerSec") as! CGFloat
    }
    
    func getMalusFuel() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "malusFuel") as! CGFloat
    }
    
    func getMalusFuelPerSec() -> CGFloat{
        return self.dataCurrentLevel.value(forKey: "malusFuelPerSec") as! CGFloat
    }
    
    func getMalusImageName() -> [String]{
        return self.dataCurrentLevel.value(forKey: "imageName") as! [String]
    }
    
    func getBonusImageName() -> String{
        return self.dataCurrentLevel.value(forKey: "imageName") as! String
    }
    
    func getItemImageName() -> String{
        return self.dataCurrentLevel.value(forKey: "imageName") as! String
    }
    
    func getItemType() -> String{
        return self.dataCurrentLevel.value(forKey: "type") as! String
    }
    
    func getItemQuantity() -> Int{
        return self.dataCurrentLevel.value(forKey: "imageName") as! Int
    }
    
    // PLANETS
    
    func getPlanets() -> [Planet]{
        
        var planets:[Planet] = [Planet]()
        for index in 0..<self.planetsData.count {
            var planetData:NSDictionary = self.planetsData.value(forKey: "Planet\(index)") as! NSDictionary
            planets.append(Planet(name: planetData.value(forKey: "name") as! String, image: planetData.value(forKey: "imageName") as! String, description: planetData.value(forKey: "description") as! String, numberOfMissions: planetData.value(forKey: "numberOfLevels") as! Int, levels: planetData.value(forKey: "Levels") as! NSDictionary))
        }
        return planets
    }
    
    // GALLERY
    func getCharactersGalleryData() -> NSDictionary{
        return self.galleryData.value(forKey: "Characters") as! NSDictionary
    }
    
    func getSpecialObjectsGalleryData() -> NSDictionary{
        return self.galleryData.value(forKey: "SpecialObjects") as! NSDictionary
    }
}
