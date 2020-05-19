//
//  Radar.swift
//  SpaceRace
//
//  Created by fernando rosa on 12/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import SpriteKit

class Radar: SKSpriteNode{
    var pings:[PingRadar] = [PingRadar]()
    var playerPing = PingRadar()
    var sceneSize:CGSize = CGSize()
    var isInError:Bool = false
    var labelError:SKLabelNode = SKLabelNode()
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "radar.atlas")
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize) {
        parentNode.addChild(self)
        self.anchorPoint.y = 0
        self.texture = textureAtlas.textureNamed("radar.png")
        self.size = size
        self.position = position
        
        self.labelError = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        self.labelError.text = ""
        self.labelError.fontColor = .red
        self.labelError.verticalAlignmentMode = .center
        self.labelError.position = CGPoint(x: 0, y: 50)
        self.labelError.fontSize = 15
        self.addChild(self.labelError)
    }
    
    func addPing(ping:PingRadar, objSpeedInScene:CGFloat, objDistanceInScene:CGFloat, objPositionInScene:CGPoint, sceneSize:CGSize){
       
            self.pings.append(ping)
            
             let pingSpeed = ((self.size.width) * objSpeedInScene)/objDistanceInScene
             let pingAnimationDuration = (self.size.width / pingSpeed)
             let pingY = ((objPositionInScene.y * self.size.height)/sceneSize.height)
             
             //print("pingY: \(pingY) -- objPositionInScene:\(objPositionInScene.y)")
             //print("pingSpeed: \(pingSpeed) -- objSpeedInScene:\(objSpeedInScene)")
             
             ping.position = CGPoint(x: (self.size.width / 2) - ping.size.width, y: pingY)
             self.addChild(ping)
             
             let pingRemove = SKAction.removeFromParent()
             let pingMove = SKAction.moveTo(x: -40, duration: TimeInterval(pingAnimationDuration))
             ping.run(SKAction.sequence([pingMove, pingRemove]))
             ping.isHidden = self.isInError
        
    }
    
    func addPlayerPing(playerSize:CGSize, playerPositionInScene:CGPoint, sceneSize:CGSize){
        
            self.playerPing.initPing(type: .player, pingName: "pingPlayer")
            let playerPingY = ((playerPositionInScene.y * self.size.height)/sceneSize.height)
            let playerPingX = -12.0
            self.playerPing.position = CGPoint(x: CGFloat(playerPingX), y: playerPingY)
            self.addChild(playerPing)
            self.sceneSize = sceneSize
        
    }
    
    func updatePlayerPosition(playerPositionInScene:CGPoint){
        
            let playerPingY = ((playerPositionInScene.y * self.size.height)/sceneSize.height)
            let playerPingX = -12.0
            self.playerPing.position = CGPoint(x: CGFloat(playerPingX), y: playerPingY)
        
    }
    
    func removePing(name:String)
    {
        if let index = self.pings.firstIndex(where: {$0.pingName == name}) {
            self.removeChildren(in: [self.pings[index]])
            self.pings.remove(at: index)
        }
    }
    
    func hideAllPing(){
        for ping in self.pings {
            ping.isHidden = true
        }
        self.playerPing.isHidden = true
    }
    
    func showAllPing(){
        for ping in self.pings {
            ping.isHidden = false
        }
        self.playerPing.isHidden = false
    }
    
    
    func error(time:Int){
        if(!self.isInError){
            self.isInError = true
            self.hideAllPing()
            self.labelError.text = "ERROR!"
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            let sequence = SKAction.sequence([fadeOut,fadeIn])
            let rep = SKAction.repeat(sequence, count: time)
            self.labelError.run(rep, completion:{
                self.labelError.text = ""
                self.isInError = false
                self.showAllPing()
            })
        }
    }
}
