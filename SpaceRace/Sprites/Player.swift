//
//  Player.swift
//
//
//  Created by fernando rosa on 05/11/2019.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "player.atlas")
    var upAnimation = SKAction()
    var downAnimation = SKAction()
    var normalAnimation = SKAction()
    var hitAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize, hasRotation: Bool = false, rotateDuration: TimeInterval = 0.0, hasAnimationWithTexture: Bool = false, textureSequence: [String] = [String](), timePerFrame: TimeInterval = 0.0) {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        self.run(self.normalAnimation, withKey: "normalAnimation")
        
        let bodyTexture = self.textureAtlas.textureNamed("character_robot_shove.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        
         self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.angularDamping = 0.0
        self.physicsBody?.mass = 30
        self.physicsBody?.contactTestBitMask = PhysicsCategory.spacejunk.rawValue | PhysicsCategory.bonus.rawValue | PhysicsCategory.itemToRecover.rawValue
        self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize, hasRotation: Bool = false, rotateDuration: TimeInterval = 0.0, hasAnimationWithTexture: Bool = false, textureSequence: [String] = [String](), timePerFrame: TimeInterval = 0.0, mainTexture:String, textureUpAnimation:String, textureDownAnimation:String, textureNormalAnimation:String) {
        parentNode.addChild(self)
        self.createThreeMainAnimations(textureUpAnimation: textureUpAnimation, textureDownAnimation: textureDownAnimation, textureNormalAnimation: textureNormalAnimation)
        self.size = size
        self.position = position
        self.run(self.normalAnimation, withKey: "normalAnimation")
        
        let bodyTexture = self.textureAtlas.textureNamed(mainTexture)
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        
        //self.physicsBody = SKPhysicsBody(rectangleOf: size)
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.angularDamping = 0.0
        self.physicsBody?.mass = 30
        self.physicsBody?.contactTestBitMask = PhysicsCategory.spacejunk.rawValue | PhysicsCategory.bonus.rawValue | PhysicsCategory.itemToRecover.rawValue
        self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    
    func createThreeMainAnimations(textureUpAnimation:String, textureDownAnimation:String, textureNormalAnimation:String){
        self.upAnimation = self.setAnimationWithTexture(sequence: [textureUpAnimation], timePerFrame: 1.0)
        self.downAnimation = self.setAnimationWithTexture(sequence: [textureDownAnimation], timePerFrame: 1.0)
        self.normalAnimation = self.setAnimationWithTexture(sequence: [textureNormalAnimation], timePerFrame: 1.0)
    }
    
    func setAnimationWithTexture(sequence: [String], timePerFrame: TimeInterval) -> SKAction {
        var sequenceAnimation:[SKTexture] = [SKTexture]()
        for index in 0...(sequence.count - 1) {
           sequenceAnimation.append(SKTexture(imageNamed: sequence[index]))
        }
        let animate = SKAction.animate(with: sequenceAnimation, timePerFrame: timePerFrame)
        return SKAction.repeatForever(animate)
    }
    
    func update(direction:CGFloat){
        if direction < -5.0 {
            self.run(self.downAnimation, withKey: "downAnimation")
        } else if direction > 5.0 {
            self.run(self.upAnimation, withKey: "upAnimation")
        } else {
            self.run(self.normalAnimation, withKey: "normalAnimation")
        }
    }
    
    func hitPlayer(){
        //
    }
    
    func setStaticImage(name: String) {
        //
    }
}
