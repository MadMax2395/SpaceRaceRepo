//
//  SpaceJunk.swift
//
//  Created by fernando rosa on 03/11/2019.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class SpaceJunk: SKSpriteNode, GameSprite {
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "spacejunk.atlas")
    var selfAnimation = SKAction()
    var sizeSpaceJunk:SizeSpaceJunk = .unkown
    var hitAnimation = SKAction()
    
    func setSizeSpaceJunk(type:SizeSpaceJunk){
        self.sizeSpaceJunk = type
    }
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize, hasRotation: Bool, rotateDuration: TimeInterval = 0.0, hasAnimationWithTexture:Bool = false, textureSequence:[String] = [String](), timePerFrame:TimeInterval = 0.0) {
        
        parentNode.addChild(self)
        self.createAnimation(hasRotation: hasRotation, rotateDuration: rotateDuration, hasAnimationWithTexture:hasAnimationWithTexture, textureSequence:textureSequence, timePerFrame:timePerFrame )
        self.size = size
        self.position = position
        self.run(self.selfAnimation)
        
    }
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize, hasRotation: Bool, rotateDuration: TimeInterval = 0.0, hasAnimationWithTexture:Bool = false, textureSequence:[String] = [String](), timePerFrame:TimeInterval = 0.0, textureSequenceForHitAnimation:[String] = [String](), timePerFrameForHitAnimation:TimeInterval = 0.0) {
        
        parentNode.addChild(self)
        self.createAnimation(hasRotation: hasRotation, rotateDuration: rotateDuration, hasAnimationWithTexture:hasAnimationWithTexture, textureSequence:textureSequence, timePerFrame:timePerFrame )
        self.createHitAnimation(textureSequence: textureSequenceForHitAnimation, timePerFrame: timePerFrameForHitAnimation)
        self.size = size
        self.position = position
        self.run(self.selfAnimation)
    }
    
    func createHitAnimation(textureSequence:[String], timePerFrame:TimeInterval){
          self.hitAnimation = self.setAnimationWithTexture(sequence: textureSequence, timePerFrame: timePerFrame)
    }
    
    func createAnimation(hasRotation: Bool, rotateDuration: TimeInterval, hasAnimationWithTexture:Bool, textureSequence:[String], timePerFrame:TimeInterval){
        
        var baseAnimation:SKAction?
        var textureAnimation:SKAction?
        var animationCounter = 0
        
        if(hasRotation){
            let rotateAnimation = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: rotateDuration)
            baseAnimation = SKAction.repeatForever(rotateAnimation)
            animationCounter += 1
        }
        
        if(hasAnimationWithTexture){
            let baseTextureAnimation = self.setAnimationWithTexture(sequence: textureSequence, timePerFrame: timePerFrame)
            textureAnimation = SKAction.repeatForever(baseTextureAnimation)
            animationCounter += 1
        }
        
        switch animationCounter {
            case 0:
                break
            case 1:
                if((baseAnimation) != nil)
                {
                    self.selfAnimation = baseAnimation!
                }
                else {
                    self.selfAnimation = textureAnimation!
                }
                break
            case 2:
                self.selfAnimation = SKAction.group([baseAnimation!,textureAnimation!])
                break
            default:
                break
        }
        
    }
    
    func setStaticImage(name: String) {
        self.texture = textureAtlas.textureNamed(name)
    }
    
    func setStaticImageAndSetPhysicsBody(name: String) {
        self.texture = textureAtlas.textureNamed(name)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.angularDamping = 0.0
        self.physicsBody?.mass = 30
        self.physicsBody?.categoryBitMask = PhysicsCategory.spacejunk.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player.rawValue
    }
    
    func setAnimationWithTexture(sequence:[String], timePerFrame: TimeInterval) -> SKAction{
        var sequenceAnimation:[SKTexture] = [SKTexture]()
        for index in 0...(sequence.count - 1) {
            sequenceAnimation.append(SKTexture(imageNamed: sequence[index]))
        }
        let animate = SKAction.animate(with: sequenceAnimation, timePerFrame: timePerFrame)
        return SKAction.repeatForever(animate)
    }
    
}
