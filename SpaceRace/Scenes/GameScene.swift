//
//  GameScene.swift
//  
//
//  Created by fernando rosa on 31/10/2019.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

enum TypeEndMission:Int{
    case endFuel = 1
    case endOxigen = 2
    case outOfBoundary = 3
    case endWin = 4
    case noEnd = 5
}

enum TouchType:Int{
    case unknown = 0
    case up = 1
    case down = 2
}

protocol GameSceneDelegate {
    func endMission(endType:TypeEndMission)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameDelegate: GameSceneDelegate?
    var endType:Int = -1
    
    func endMission(endType:TypeEndMission) {
        self.gameDelegate?.endMission(endType:endType)
    }
    
    let world = SKNode()
    var hud = HUD()
    var space = Space()
    var player = Player()
    var playerData:PlayerData = PlayerData()
    var radar = Radar()
    let motionManager = CMMotionManager()
    var first = true
    var initialAngle = 0.0
    
    var touchMoveUpActive:Bool = false
    var touchYRef:CGFloat = 0.0
    var lastTouch:TouchType = .unknown
    var touchMoveDownActive:Bool = false
    var touchActive:Bool = false

    var spaceJunk:[SpaceJunk] = [SpaceJunk]()
    var spaceJunkCounter = 0
    var sceneIsRemovingSpaceJunk:Bool = false
    
    var spaceBonus:[SpaceBonus] = [SpaceBonus]()
    var spaceBonusCounter = 0
    var sceneIsRemovingSpaceBonus:Bool = false
    
    var items :[ItemToRecover] = [ItemToRecover]()
    var itemCounter = 0
    var sceneIsRemovingItem:Bool = false
    var itemsRecovered : Int = 0
    
    var rocksound = SKAction.playSoundFileNamed("rockcollision.wav", waitForCompletion: false)
    var powerUpSound = SKAction.playSoundFileNamed("powerup.wav", waitForCompletion: false)
    var itemGained = SKAction.playSoundFileNamed("itemgained.wav", waitForCompletion: false)
    var backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
    
    var gameOver : Bool = false
    
    var kitOxigenSpawned = false
    var kitFuelSpawned = false
    
    var level:Int = 0
    
    var itemsIndicator:ItemsMission!
    
    
    func setDataLevel(level:Int){
        self.level = level
        self.playerData = PlayerData(level:level)
    }
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .black
        self.addChild(self.world)
        
        self.addSpace()
        self.addPlayer()
        self.addRadar()
        self.addHUD()
        
        self.touchYRef = self.player.position.y
        
        if !GameManager.shared.isTouchEnabled(){
            self.motionManager.startAccelerometerUpdates()
        }
        
        self.view?.isMultipleTouchEnabled = false
        
        self.physicsWorld.contactDelegate = self
        
        self.addChild(backgroundMusic)
        if(GameManager.shared.isMusicEnabled()){
            self.backgroundMusic.run(SKAction.play())
        }else{
            self.backgroundMusic.run(SKAction.stop())
        }
    
        //SPAWN ITEMS
        let spawnItemAction : SKAction = SKAction.run{ self.spawnItem() }
        let waitActionItem = SKAction.wait(forDuration : TimeInterval(Int.random(in : 8...14)))
        let sequence  = SKAction.sequence([spawnItemAction,waitActionItem])
        run(SKAction.repeatForever(sequence))
    }
    
    func resetAndRetry(){
        self.itemsRecovered = 0
        self.world.removeAllChildren()
        self.removeAllChildren()
        
        self.playerData = PlayerData(level:level)
        
        self.rocksound = SKAction.playSoundFileNamed("rockcollision.wav", waitForCompletion: false)
        self.powerUpSound = SKAction.playSoundFileNamed("powerup.wav", waitForCompletion: false)
        self.itemGained = SKAction.playSoundFileNamed("itemgained.wav", waitForCompletion: false)
        self.backgroundMusic = SKAudioNode(fileNamed: "background.mp3")
        
        self.addChild(self.world)
        self.spaceJunk.removeAll()
        self.spaceBonus.removeAll()
        self.items.removeAll()
        
        
        self.addSpace()
        self.radar = Radar()
        self.addRadar()
        self.player = Player()
        self.addPlayer()
        self.hud = HUD()
        self.addHUD()
            
        self.touchYRef = self.player.position.y
        
        if !GameManager.shared.isTouchEnabled(){
            self.motionManager.startAccelerometerUpdates()
        }
        
        self.view?.isMultipleTouchEnabled = false
        
        self.physicsWorld.contactDelegate = self
        
        self.addChild(backgroundMusic)
        if(GameManager.shared.isMusicEnabled()){
            self.backgroundMusic.run(SKAction.play())
        }else{
            self.backgroundMusic.run(SKAction.stop())
        }
    
        //SPAWN ITEMS
        let spawnItemAction : SKAction = SKAction.run{ self.spawnItem() }
        let waitActionItem = SKAction.wait(forDuration : TimeInterval(Int.random(in : 8...14)))
        let sequence  = SKAction.sequence([spawnItemAction,waitActionItem])
        run(SKAction.repeatForever(sequence))
        
    }
    
    func addHUD(){
        self.hud = HUD()
        self.hud.initHUD(parentNode: self.world, position: CGPoint(x: 220,y: 40), size: CGSize(width: 300, height: 100))
        self.itemsIndicator = ItemsMission()
        self.itemsIndicator.spawn(parentNode: self.world,  position: CGPoint(x: self.size.width - 45,y: 30), size: CGSize(width: 50, height: 50))
        
    }
    
    func addRadar(){
        self.radar.spawn(parentNode: self, position: CGPoint(x: 50,y: 20), size: CGSize(width: 100, height: 100))
        self.player.zPosition = -50
    }
    
    func addPlayer(){
        self.player.spawn(parentNode: self, position: CGPoint(x: self.size.width/2 - 100,y:self.size.height/2), size: CGSize(width: 100, height: 100), hasRotation: false, rotateDuration: 0, hasAnimationWithTexture: false, textureSequence: [String](), timePerFrame: 0, mainTexture: GameManager.shared.getCurrentPlayerImage(), textureUpAnimation: GameManager.shared.getCurrentPlayerImageUp(), textureDownAnimation: GameManager.shared.getCurrentPlayerImageDown(), textureNormalAnimation: GameManager.shared.getCurrentPlayerImage())
        self.player.zPosition = -40
        self.radar.addPlayerPing(playerSize: self.player.size, playerPositionInScene: self.player.position, sceneSize: self.size)
    }
    
    func addSpace(){
        
        let spacePosition = CGPoint(x: 0, y: self.size.height)
        let spaceSize = CGSize(width: self.size.width, height: 0)
        self.space.spawn(parentNode: self, position: spacePosition, size: spaceSize, hasRotation: false, rotateDuration: 0, hasAnimationWithTexture: false, textureSequence: [String](), timePerFrame: 0)
        self.space.zPosition = -100
             
    }
    
    override func didSimulatePhysics() {
        //let worldXPos = -(self.player.position.x * self.world.xScale - (self.size.width / 2))
        //let worldYPos = -(self.player.position.y * self.world.yScale - (self.size.height / 2))
        //self.world.position = CGPoint(x: worldXPos, y:worldYPos)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
           let location = touch.location(in: self)
            if location.y > self.touchYRef {
                       self.touchMoveUpActive = true
                    self.touchMoveDownActive  = false
                       self.touchActive = true
               }else{
                       self.touchMoveDownActive = true
                    self.touchMoveUpActive = false
                       self.touchActive = true
               }
           }
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          for touch in touches {
             let location = touch.location(in: self)
             if !self.touchActive{
                 if location.y > self.touchYRef {
                     //self.lastTouch = .up
                     if !self.touchMoveUpActive {
                         self.touchMoveUpActive = true
                         self.touchActive = true
                     }
                 }else{
                     //self.lastTouch = .down
                     if !self.touchMoveDownActive {
                         self.touchMoveDownActive = true
                         self.touchActive = true
                     }
                 }
             }
          }
      }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchActive = false
        self.touchMoveUpActive = false
        self.touchMoveDownActive = false
    }

    
    override func update(_ currentTime: TimeInterval) {
        self.touchYRef = self.player.position.y
        // Update player in scene
        if !GameManager.shared.isTouchEnabled(){
            self.updateWithAccelerometer()
        }
        else{
            self.updateWithTouch()
        }
        
        // Update player position in radar
        self.radar.updatePlayerPosition(playerPositionInScene: self.player.position)
        
        // decision about spawn space junk
        if(self.spaceJunk.count < 5)
        {
            self.spawnSpaceJunk()
        }
        
        // decision about spawn bonus
        if(self.spaceBonus.count < 2 && self.spaceJunk.count > 4)
        {
            self.spawnSpaceBonus()
        }
        
        if((self.playerData.getCurrentOxygenPerSec() > self.playerData.getStandardOxygenPerSec()) && !self.kitOxigenSpawned){
            self.spawnSpaceKit(type:TypeBonus.repairOxygen)
        }
        
        if((self.playerData.getCurrentFuelPerSec() > self.playerData.getStandardFuelPerSec()) && !self.kitFuelSpawned){
            self.spawnSpaceKit(type:TypeBonus.repairFuel)
        }
        
        self.playerData.consumeOxigen()
        self.displayPlayerData()
        
        let endCondition = self.checkEndCondition(data: playerData)
        if(endCondition != TypeEndMission.noEnd){
            self.isPaused = true
            self.endMission(endType: endCondition)
        }
    }
    
    func updateWithAccelerometer(){

         var movement = CGVector()
         if let data = self.motionManager.accelerometerData {
             
             let z = -data.acceleration.z
             let y = data.acceleration.y
             var zEff = z
             
             if z > 1{
                 zEff = 1
             } else if z < -1 {
                 zEff = -1
             }
             
             if first {
                 if z > 0 && y > 0 {
                     initialAngle = -acos(zEff)
                 } else if z < 0 && y > 0 {
                     initialAngle = -acos(zEff)
                 } else {
                     initialAngle = acos(zEff)
                 }
                 first = false
             }
             
             let a :Double
             
             if z > 0 && y > 0 {
                 a = -acos(zEff)
             } else if z < 0 && y > 0 {
                 a = -acos(zEff)
             } else {
                 a = acos(zEff)
             }
             
             let b = -sin(a - initialAngle)
             
             zEff = b
             
             movement.dy = CGFloat(zEff * 10000)
             
            
             if abs(zEff) > 0.1 {
                 self.player.physicsBody!.applyForce(CGVector(dx: 0, dy: zEff*30000))
                 self.playerData.consumeFuel()
             }
             self.player.update(direction: self.player.physicsBody!.velocity.dy)
             //print("\(self.player.physicsBody!.velocity.dy)")
             
        }
    }
    
    func updateWithTouch(){
        
        
        var movement = CGVector()
        var zEff = 0
        if self.touchMoveUpActive {
            zEff = 1
            self.playerData.consumeFuel()
        }
        else if self.touchMoveDownActive {
            zEff = -1
            self.playerData.consumeFuel()
        }
        movement.dy = CGFloat(zEff * 10000)
        self.player.physicsBody!.applyForce(movement)
        self.player.update(direction: self.player.physicsBody!.velocity.dy)
        
        //print("\(self.player.physicsBody!.velocity.dy)")
    }
    
    func spawnSpaceBonus(){
        
        let sb:SpaceBonus = SpaceBonus()
        let randombonus = (Int.random(in: 1 ... 2))
        let randomSbY = CGFloat(Float.random(in: 36 ..< Float(self.size.height - 36)))
        let randomSbActionDuration = TimeInterval(Float.random(in: 2 ..< 10))
        // SPAWN SENZA ANIMAZIONI
        //sb.spawn(parentNode: self, position: CGPoint(x: self.size.width + (self.size.width * 0.5), y: randomSbY), size: CGSize(width: (randombonus == 1 ? 44 : 25), height: 50), hasRotation: false)
        // SPAWN CON ANIMAZIONI
        sb.spawn(parentNode: self, position: CGPoint(x: self.size.width + (self.size.width * 0.5), y: randomSbY), size: CGSize(width: (randombonus == 1 ? 44 : 25), height: 50), hasRotation: true, rotateDuration: TimeInterval(Float.random(in: 1 ..< 4)), hasAnimationWithTexture: false, textureSequence:[], timePerFrame: 0.0)
        
        sb.setStaticImageAndSetPhysicsBody(name: randombonus == 1 ? "fuel.png" : "oxigen.png", category: PhysicsCategory.bonus)
        sb.typeBonus = ((randombonus == 1) ? TypeBonus.fuel : TypeBonus.oxygen )
        self.spaceBonusCounter += 1
        sb.name = "spaceBonus\(self.spaceBonusCounter)"
        sb.zPosition = -40
        
        let spaceBonusActionMove = SKAction.moveTo(x: -sb.size.width/2, duration:randomSbActionDuration )
        let spaceBonusActionRemove = SKAction.removeFromParent()
        sb.run(SKAction.sequence([spaceBonusActionMove,spaceBonusActionRemove]),
        completion:{
            self.removeSpaceBonus(name: sb.name!)
        } )
        let sbDistance = ((self.size.width + (self.size.width * 0.5)) + sb.size.width/2)
        let sbSpeed =  ((self.size.width + (self.size.width * 0.5)) + sb.size.width/2) / CGFloat(randomSbActionDuration)
        
        let ping = PingRadar()
        ping.initPing(type: .bonus, pingName: sb.name!)
        self.spaceBonus.append(sb)
        self.radar.addPing(ping: ping, objSpeedInScene: sbSpeed, objDistanceInScene: sbDistance, objPositionInScene: sb.position, sceneSize: self.size)
        
    }
    
    func spawnSpaceKit(type: TypeBonus){
        
        let sb:SpaceBonus = SpaceBonus()
        let randomSbY = CGFloat(Float.random(in: 36 ..< Float(self.size.height - 36)))
        let randomSbActionDuration = TimeInterval(Float.random(in: 2 ..< 10))
        sb.spawn(parentNode: self, position: CGPoint(x: self.size.width + (self.size.width * 0.5), y: randomSbY), size: CGSize(width: 30, height: 30), hasRotation: true, rotateDuration: TimeInterval(Float.random(in: 1 ..< 4)), hasAnimationWithTexture: false, textureSequence:[], timePerFrame: 0.0)
        
        sb.setStaticImageAndSetPhysicsBody(name: type == TypeBonus.repairFuel ? "kitFuel.png" : "kitOxigen.png", category: type == TypeBonus.repairFuel ? PhysicsCategory.repairFuel : PhysicsCategory.repairOxigen)
        sb.typeBonus = ((type == TypeBonus.repairFuel) ? TypeBonus.repairFuel : TypeBonus.repairOxygen )
        self.spaceBonusCounter += 1
        sb.name = "spaceBonus\(self.spaceBonusCounter)"
        sb.zPosition = -40
        
        let spaceBonusActionMove = SKAction.moveTo(x: -sb.size.width/2, duration:randomSbActionDuration )
        let spaceBonusActionRemove = SKAction.removeFromParent()
        
        if(type == TypeBonus.repairOxygen){self.kitOxigenSpawned = true}
        if(type == TypeBonus.repairFuel){self.kitFuelSpawned = true}
        
        sb.run(SKAction.sequence([spaceBonusActionMove,spaceBonusActionRemove]),
        completion:{
            if(type == TypeBonus.repairOxygen){self.kitOxigenSpawned = false}
            if(type == TypeBonus.repairFuel){self.kitFuelSpawned = false}
            self.removeSpaceBonus(name: sb.name!)
        } )
        let sbDistance = ((self.size.width + (self.size.width * 0.5)) + sb.size.width/2)
        let sbSpeed =  ((self.size.width + (self.size.width * 0.5)) + sb.size.width/2) / CGFloat(randomSbActionDuration)
        
        let ping = PingRadar()
        ping.initPing(type: .bonus, pingName: sb.name!)
        self.spaceBonus.append(sb)
        self.radar.addPing(ping: ping, objSpeedInScene: sbSpeed, objDistanceInScene: sbDistance, objPositionInScene: sb.position, sceneSize: self.size)
        
    }
    
    func spawnSpaceJunk(){
        
        let sj:SpaceJunk = SpaceJunk()
        let randomSjY = CGFloat(Float.random(in: 36 ..< Float(self.size.height - 36)))
        let randomSjActionDuration = TimeInterval(Float.random(in: 2 ..< 10))
        // SPAWN SENZA ANIMAZIONI
        sj.spawn(parentNode: self, position: CGPoint(x: self.size.width + (self.size.width * 0.5), y: randomSjY), size: CGSize(width: 50, height: 36), hasRotation: false)
        sj.setStaticImageAndSetPhysicsBody(name: "smallRock\(Int.random(in: 1 ... 2)).png")
        self.spaceJunkCounter += 1
        sj.name = "spaceJunk\(self.spaceJunkCounter)"
        sj.zPosition = -40
        
        let spaceJunkActionMove = SKAction.moveTo(x: -sj.size.width/2, duration:randomSjActionDuration )
        let spaceJunkActionRemove = SKAction.removeFromParent()
        sj.run(SKAction.sequence([spaceJunkActionMove,spaceJunkActionRemove]),
        completion:{
            self.removeSpaceJunk(name: sj.name!)
        } )
        let sjDistance = ((self.size.width + (self.size.width * 0.5)) + sj.size.width/2)
        let sjSpeed =  ((self.size.width + (self.size.width * 0.5)) + sj.size.width/2) / CGFloat(randomSjActionDuration)
        
        let ping = PingRadar()
        ping.initPing(type: .malus, pingName: sj.name!)
        self.spaceJunk.append(sj)
        self.radar.addPing(ping: ping, objSpeedInScene: sjSpeed, objDistanceInScene: sjDistance, objPositionInScene: sj.position, sceneSize: self.size)
        
    }
    
    func spawnItem(){
        
        let item:ItemToRecover = ItemToRecover()
        let randomItemY = CGFloat(Float.random(in: 36 ..< Float(self.size.height - 36)))
        let randomItemActionDuration = TimeInterval(Float.random(in: 2 ..< 15))
        // SPAWN SENZA ANIMAZIONI
        item.spawn(parentNode: self, position: CGPoint(x: self.size.width + (self.size.width * 0.5), y: randomItemY), size: CGSize(width: 40, height: 40), hasRotation: false)
        item.setStaticImageAndSetPhysicsBody(name: "itemNew.png")
        self.itemCounter += 1
        item.name = "item\(self.itemCounter)"
        item.zPosition = -40
        
        let itemActionMove = SKAction.moveTo(x: -item.size.width/2, duration:randomItemActionDuration )
        let itemActionRemove = SKAction.removeFromParent()
        item.run(SKAction.sequence([itemActionMove,itemActionRemove]),
        completion:{
            self.removeItem(name: item.name!)
        } )
        let itemDistance = ((self.size.width + (self.size.width * 0.5)) + item.size.width/2)
        let itemSpeed =  ((self.size.width + (self.size.width * 0.5)) + item.size.width/2) / CGFloat(randomItemActionDuration)
        
        let ping = PingRadar()
        ping.initPing(type: .pieceToRecover, pingName: item.name!)
        self.items.append(item)
        self.radar.addPing(ping: ping, objSpeedInScene: itemSpeed, objDistanceInScene: itemDistance, objPositionInScene: item.position, sceneSize: self.size)
        
    }
    
    func removeItem(name:String){
           if let index = self.items.firstIndex(where: {$0.name == name}) {
               self.items.remove(at: index)
           }
           self.radar.removePing(name: name)
           self.sceneIsRemovingItem = false
           self.player.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
       }
    
    func removeSpaceJunk(name:String){
        if let index = self.spaceJunk.firstIndex(where: {$0.name == name}) {
            self.spaceJunk.remove(at: index)
        }
        self.radar.removePing(name: name)
        self.sceneIsRemovingSpaceJunk = false
        self.player.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
    }
    
    func removeSpaceBonus(name:String){
        if let index = self.spaceBonus.firstIndex(where: {$0.name == name}) {
            self.spaceBonus.remove(at: index)
        }
        self.radar.removePing(name: name)
        self.sceneIsRemovingSpaceBonus = false
        self.player.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherBody:SKPhysicsBody
        
        let playerMask = PhysicsCategory.player.rawValue | PhysicsCategory.immunePlayer.rawValue
        if (contact.bodyA.categoryBitMask & playerMask) > 0 {
            // bodyA is the player, we will test bodyB:
            otherBody = contact.bodyB
        }
        else {
            // bodyB is the player, we will test bodyA:
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
        case PhysicsCategory.spacejunk.rawValue:
            print("SpaceJunk:\((otherBody.node as! SpaceJunk).name!)")
            self.player.physicsBody?.categoryBitMask = PhysicsCategory.immunePlayer.rawValue
            if(!self.sceneIsRemovingSpaceJunk){
                self.sceneIsRemovingSpaceJunk = true
                let damage:DamageType = DamageType(rawValue: Int.random(in: 1 ... 3))!
                self.playerHitSpaceJunk(damage: damage)
                if(GameManager.shared.isSoundEffetsEnabled()){run(rocksound)}
                self.removeChildren(in: [otherBody.node!])
                self.removeSpaceJunk(name: (otherBody.node as! SpaceJunk).name!)
                if(GameManager.shared.isSoundEffetsEnabled()){run(rocksound)}
            }
            break
        case PhysicsCategory.bonus.rawValue:
            print("Bonus:\((otherBody.node as! SpaceBonus).name!)")
            self.player.physicsBody?.categoryBitMask = PhysicsCategory.immunePlayer.rawValue
            if(!self.sceneIsRemovingSpaceBonus){
                self.sceneIsRemovingSpaceBonus = true
                self.playerHitBonus(bonusType: (otherBody.node as! SpaceBonus).typeBonus)
                if(GameManager.shared.isSoundEffetsEnabled()){run(powerUpSound)}
                self.removeChildren(in: [otherBody.node!])
                if(GameManager.shared.isSoundEffetsEnabled()){run(powerUpSound)}
                self.removeSpaceBonus(name: (otherBody.node as! SpaceBonus).name!)
            }
            break
        case PhysicsCategory.itemToRecover.rawValue:
                print("Item:\((otherBody.node as! ItemToRecover).name!)")
                self.player.physicsBody?.categoryBitMask = PhysicsCategory.immunePlayer.rawValue
                if(!self.sceneIsRemovingItem){
                    self.sceneIsRemovingItem = true
                    self.playerHitItem()
                    if(GameManager.shared.isSoundEffetsEnabled()){run(itemGained)}
                    self.removeChildren(in: [otherBody.node!])
                    if(GameManager.shared.isSoundEffetsEnabled()){run(itemGained)}
                    self.removeItem(name: (otherBody.node as! ItemToRecover).name!)
                }
                break
        case PhysicsCategory.repairFuel.rawValue:
            print("RepairFuel:\((otherBody.node as! SpaceBonus).name!)")
            self.player.physicsBody?.categoryBitMask = PhysicsCategory.immunePlayer.rawValue
            if(!self.sceneIsRemovingSpaceBonus){
                self.sceneIsRemovingSpaceBonus = true
                self.playerHitBonus(bonusType: (otherBody.node as! SpaceBonus).typeBonus)
                self.playerData.repair(repair: (otherBody.node as! SpaceBonus).typeBonus)
                self.hud.diableFuelAllarm()
                if(GameManager.shared.isSoundEffetsEnabled()){run(powerUpSound)}
                self.removeChildren(in: [otherBody.node!])
                if(GameManager.shared.isSoundEffetsEnabled()){run(powerUpSound)}
                self.removeSpaceBonus(name: (otherBody.node as! SpaceBonus).name!)
            }
            break
        case PhysicsCategory.repairOxigen.rawValue:
            print("RepairOx:\((otherBody.node as! SpaceBonus).name!)")
            self.player.physicsBody?.categoryBitMask = PhysicsCategory.immunePlayer.rawValue
            if(!self.sceneIsRemovingSpaceBonus){
                self.sceneIsRemovingSpaceBonus = true
                self.playerData.repair(repair: (otherBody.node as! SpaceBonus).typeBonus)
                self.hud.diableOxygenAllarm()
                if(GameManager.shared.isSoundEffetsEnabled()){run(powerUpSound)}
                self.playerHitBonus(bonusType: (otherBody.node as! SpaceBonus).typeBonus)
                self.removeChildren(in: [otherBody.node!])
                if(GameManager.shared.isSoundEffetsEnabled()){run(powerUpSound)}
                self.removeSpaceBonus(name: (otherBody.node as! SpaceBonus).name!)
            }
            break
        default:
            print("Unknown")
        }
    }
    
    func playerHitSpaceJunk(damage:DamageType){
        if(damage != .radar){
            self.playerData.damage(damage: damage)
            self.hud.damageAllarm(damage: damage)
        }else{
            self.radar.error(time: 10)
        }
    }
    
    func playerHitBonus(bonusType:TypeBonus){
        self.playerData.bonus(bonus: bonusType)
        // TODO
        // animazione bonus
    }
    
    func displayPlayerData(){
        //print("OXIGEN:\(self.playerData.getCurrentOxygen())")
        //print("FUEL:\(self.playerData.getCurrentFuel())")
        self.hud.updateFuelBar(qty: self.playerData.getCurrentFuel(), max: self.playerData.getMaxFuel())
        self.hud.updateOxigenBar(qty: self.playerData.getCurrentOxygen(), max: self.playerData.getMaxOxygen())
    }
    
    
    func checkLoseCondition( data : PlayerData)->Bool{
        if ((data.getCurrentOxygen()<=0 || data.getCurrentFuel()<=0))
        {
            return true
         }
        else
        {
            return false
        }
    }
    
    func leaveLEvel(){
        self.backgroundMusic.run(SKAction.stop())
    }
    
    func stopMusic(){
        self.backgroundMusic.run(SKAction.stop())
    }
    
    func playMusic(){
        self.backgroundMusic.run(SKAction.play())
    }
    
    func playerHitItem(){
        self.itemsRecovered += 1
        self.hud.updateRecoveredItem(recovered: self.itemsRecovered, of: 3)
        self.itemsIndicator.itemHit()
    }
    
    func checkEndCondition( data : PlayerData) -> TypeEndMission{
        
        if (itemsRecovered >= 3){
             return TypeEndMission.endWin
        }
        if self.player.position.y - (self.player.frame.size.height / 2) >= (self.view?.frame.size.height)!{
            return TypeEndMission.outOfBoundary
        }
        if self.player.position.y + (self.player.frame.size.height / 2) <= 0{
            return TypeEndMission.outOfBoundary
        }
        if (data.getCurrentOxygen()<=0)
        {
            return TypeEndMission.endOxigen
        }
        if (data.getCurrentFuel()<=0)
        {
            return TypeEndMission.endFuel
        }
        
        return TypeEndMission.noEnd
    }
}
