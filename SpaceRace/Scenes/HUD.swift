//
//  HUD.swift
//  SpaceRace
//
//  Created by fernando rosa on 15/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//
import SpriteKit

class HUD: SKNode {
    
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"hud.atlas")
    var oxigenBar:SKSpriteNode = SKSpriteNode()
    var labelOxigen:SKLabelNode = SKLabelNode()
    var fuelBar:SKSpriteNode = SKSpriteNode()
    var labelFuel:SKLabelNode = SKLabelNode()
    
    var numberOfItemLabel = SKLabelNode()
    
    var fuelAllarmActive:Bool = false
    var oxygenAllarmActive:Bool = false
    
    
    
    
    func initHUD(parentNode:SKNode, position: CGPoint, size:CGSize){
        self.createOxigenBar(screenSize: size)
        self.createFuelBar(screenSize: size)
        self.createNumberOfItemLabel(screenSize: size)
       
        parentNode.addChild(self)
        self.position = position
    }
    
    func createNumberOfItemLabel(screenSize:CGSize){
        self.numberOfItemLabel = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        self.numberOfItemLabel.text = "0/3"
        self.numberOfItemLabel.verticalAlignmentMode = .center
        self.numberOfItemLabel.position = CGPoint(x: screenSize.width - 150, y: 50)
        self.numberOfItemLabel.fontSize = 20
        self.addChild(self.numberOfItemLabel)
    }
    
    func createOxigenBar(screenSize:CGSize){
        self.oxigenBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.oxigenBar.constraints = [SKConstraint.positionX(SKRange(constantValue: 0.0))]
        self.oxigenBar = SKSpriteNode(color: .green, size: CGSize(width: screenSize.width * 0.7, height: screenSize.height * 0.2))
        self.oxigenBar.position = CGPoint(x: 0.5, y: 0)
        self.addChild(self.oxigenBar)
        
        self.labelOxigen = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        self.labelOxigen.text = "100%"
        self.labelOxigen.verticalAlignmentMode = .center
        self.labelOxigen.position = CGPoint(x: 0, y: 0)
        self.labelOxigen.fontSize = 10
        self.addChild(self.labelOxigen)
        self.labelOxigen.zPosition = self.oxigenBar.zPosition + 1
    }
    
    func createFuelBar(screenSize:CGSize){
        self.fuelBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.fuelBar.constraints = [SKConstraint.positionX(SKRange(constantValue: 0.0))]
        self.fuelBar = SKSpriteNode(color: .red, size: CGSize(width: screenSize.width * 0.7, height: screenSize.height * 0.2))
        self.fuelBar.position = CGPoint(x: 0, y: (screenSize.height * 0.5))
        self.addChild(self.fuelBar)
        
        self.labelFuel = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        self.labelFuel.text = "100%"
        self.labelFuel.verticalAlignmentMode = .center
        self.labelFuel.position = CGPoint(x: 0, y: (screenSize.height * 0.5))
        self.labelFuel.fontSize = 10
        self.addChild(self.labelFuel)
        self.labelFuel.zPosition = self.fuelBar.zPosition + 1
    }
    
    func updateOxigenBar(qty:Float,max:Float){
        let scaleValue = CGFloat((max - qty)/max)
        self.oxigenBar.xScale = (1 - scaleValue)
        self.labelOxigen.text = ("\( Int((1 - scaleValue) * 100))%")
    }
    
    func updateFuelBar(qty:Float,max:Float){
        let scaleValue = CGFloat((max - qty)/max)
        self.fuelBar.xScale = (1 - scaleValue)
        self.labelFuel.text = ("\( Int((1 - scaleValue) * 100))%")
    }
    
    func updateRecoveredItem(recovered:Int, of:Int){
        self.numberOfItemLabel.text = "\(recovered)/\(of)"
    }
    
    func enableFuelAllarm(){
        if(!self.fuelAllarmActive){
            self.fuelAllarmActive = true
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            let sequence = SKAction.sequence([fadeOut,fadeIn])
            let rep = SKAction.repeatForever(sequence)
            self.fuelBar.run(rep, withKey: "fuelallarm")
        }
    }
    
    func diableFuelAllarm(){
        self.fuelBar.removeAllActions()
        self.fuelBar.alpha = 1.0
        self.fuelAllarmActive = false
    }
    
    func enableOxygenAllarm(){
        if(!self.oxygenAllarmActive){
            self.oxygenAllarmActive = true
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            let sequence = SKAction.sequence([fadeOut,fadeIn])
            let rep = SKAction.repeatForever(sequence)
            self.oxigenBar.run(rep, withKey: "oxygenallarm")
        }
    }
    
    func diableOxygenAllarm(){
        self.oxigenBar.removeAllActions()
        self.oxigenBar.alpha = 1.0
        self.oxygenAllarmActive = false
    }
    
    func damageAllarm(damage:DamageType){
        switch damage {
        case .oxigen:
            self.enableOxygenAllarm()
            break
        case .fuel:
            self.enableFuelAllarm()
            break
        default:
            print("error")
        }
    }
}
