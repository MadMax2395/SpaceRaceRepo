//
//  Space.swift
//
//
//  Created by fernando rosa on 05/11/2019.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class Space: SKSpriteNode{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "background.atlas")
    var backgroundTexture:SKTexture?
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize, hasRotation: Bool, rotateDuration: TimeInterval, hasAnimationWithTexture: Bool, textureSequence: [String], timePerFrame: TimeInterval) {
        parentNode.addChild(self)
        self.position = position
        self.size = size
        self.anchorPoint = CGPoint(x: 0,y: 1)
        
        if self.backgroundTexture == nil {
            self.setStaticImage(name: "back.png")
        }
        
        self.createChildren()
    }
    
    func setStaticImage(name: String) {
        self.backgroundTexture = textureAtlas.textureNamed(name)
    }
    
    func createChildren(){
        if let texture = self.backgroundTexture {
            var tileCount:CGFloat = 0
            let textureSize = texture.size()
            let tileSize = CGSize(width: textureSize.width, height: textureSize.height)
            
            while tileCount * tileSize.width < self.size.width {
                let tileNode = SKSpriteNode(texture: self.backgroundTexture)
                tileNode.size = tileSize
                tileNode.position.x = tileCount * tileSize.width
                tileNode.anchorPoint = CGPoint(x: 0, y: 1)
                self.addChild(tileNode)
                tileCount += 1
            }
        }
    }
    
}
