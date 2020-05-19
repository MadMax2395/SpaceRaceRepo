//
//  PlayerData.swift
//  SpaceRace
//
//  Created by fernando rosa on 14/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class PlayerData {
    
    private var currentOxygen : Float
    private var maxOxygen: Float
    private var currentFuel: Float
    private var maxFuel: Float
    private var currentOxygenPerSec: Float
    private var currentFuelPerSec: Float
    private var standardOxygenPerSec: Float
    private var standardFuelPerSec: Float
    private var safeBoundaries: Bool
    
    init(){
        
        self.maxOxygen = -1
        self.currentOxygen = -1
        self.maxFuel = -1
        self.currentFuel = -1
        self.standardOxygenPerSec = -1
        self.standardFuelPerSec = -1
        self.currentOxygenPerSec = -1
        self.currentFuelPerSec = -1
        self.safeBoundaries = false
    }
    
    init(level:Int) {
        
        let levelDataPlayer :NSDictionary = ResourceManager.shared.loadLevelPlayer(level: level)!
        GameManager.shared.setDataCurrentPlayer(data: levelDataPlayer)
        
        self.maxOxygen = Float(GameManager.shared.getCurrentPlayerMaxOxygen())
        self.currentOxygen = self.maxOxygen
        self.maxFuel = Float(GameManager.shared.getCurrentPlayerFuel())
        self.currentFuel = self.maxFuel
        self.standardOxygenPerSec = Float(GameManager.shared.getCurrentPlayerOxPerSec())
        self.standardFuelPerSec = Float(GameManager.shared.getCurrentPlayerFuelPerSec())
        self.currentOxygenPerSec = self.standardOxygenPerSec
        self.currentFuelPerSec = self.standardOxygenPerSec
        
        self.safeBoundaries = false
    }
    
    func getMaxOxygen() -> Float{
        return self.maxOxygen
    }
    
    func getCurrentOxygen() -> Float{
        return self.currentOxygen
    }
    
    func getMaxFuel() -> Float{
        return self.maxFuel
    }
    
    func getCurrentFuel() -> Float{
        return self.currentFuel
    }
    
    func getCurrentOxygenPerSec() -> Float{
        return self.currentOxygenPerSec
    }
    
    func getCurrentFuelPerSec() -> Float{
        return self.currentFuelPerSec
    }
    
    func getStandardOxygenPerSec() -> Float{
        return self.standardOxygenPerSec
    }
    
    func getStandardFuelPerSec() -> Float{
        return self.standardFuelPerSec
    }
    
    func getSafeBoundaries() -> Bool{
        return self.safeBoundaries
    }
    
    func setMaxOxygen(newMax: Float){
        self.maxOxygen = newMax
    }
    
    func setCurrentOxygen(newCurrent: Float){
        self.currentOxygen = newCurrent
    }
    
    func setMaxFuel(newMax: Float){
        self.maxFuel = newMax
    }
    
    func setCurrentFuel(newCurrent: Float){
        self.currentFuel = newCurrent
    }
    
    func setCurrentOxygenPerSec(newRate: Float){
        self.currentOxygenPerSec = newRate
    }
    
    func setCurrentFuelPerSec(newRate: Float){
        self.currentFuelPerSec = newRate
    }
    
    func setStandardOxygenPerSec(newStandardRate: Float){
        self.standardOxygenPerSec = newStandardRate
    }
       
    func setStandardFuelPerSec(newStandardRate: Float){
        self.standardFuelPerSec = newStandardRate
    }
    
    func setSafeBoundaries(newParameter: Bool){
        self.safeBoundaries = newParameter
    }
    
    func consumeOxigen(){
        if(self.currentOxygen > 0)
        {
            self.currentOxygen -= (self.currentOxygenPerSec/60)
        }
        else
        {
            self.currentOxygen = 0
        }
    }
    
    func consumeFuel(){
        if(self.currentFuel > 0){
            self.currentFuel -= (self.currentFuelPerSec/60)
        }
        else
        {
            self.currentFuel = 0
        }
    }
    
    func damage(damage:DamageType){
        switch damage {
        case .oxigen:
            self.setCurrentOxygenPerSec(newRate: self.currentOxygenPerSec + 0.5)
            break
        case .fuel:
            self.setCurrentFuelPerSec(newRate: self.currentFuelPerSec + 0.5)
            break
        default:
            print("error")
        }
    }
    
    func repair(repair:TypeBonus){
        switch repair {
        case .repairOxygen:
            self.setCurrentOxygenPerSec(newRate: self.standardOxygenPerSec)
            break
        case .repairFuel:
            self.setCurrentFuelPerSec(newRate: self.standardOxygenPerSec)
            break
        default:
            print("error")
        }
    }
    
    func bonus(bonus:TypeBonus){
        switch bonus {
        case .fuel:
            self.setCurrentFuel(newCurrent: self.maxFuel)
            break
        case .oxygen:
            self.setCurrentOxygen(newCurrent: self.maxOxygen)
            break
        case .repairOxygen:
            self.setCurrentOxygenPerSec(newRate: self.standardOxygenPerSec)
            break
        case .repairFuel:
            self.setCurrentFuelPerSec(newRate: self.standardFuelPerSec)
            break
        case .boundary:
            print("bonus:boundary")
            break
        case .unkown:
            print("bonus:unknown")
            break
        default:
            print("error")
        }
    }
    
}
