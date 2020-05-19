//
//  ItemsMission.swift
//  SpaceRace
//
//  Created by fernando rosa on 25/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import SpriteKit

class ItemsMission: SKSpriteNode{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "bonus.atlas")
    var star:SKSpriteNode = SKSpriteNode()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize) {
        parentNode.addChild(self)
        self.anchorPoint.y = 0
        self.texture = textureAtlas.textureNamed("itemNew.png")
        self.size = size
        self.position = position
        
        self.star.texture = textureAtlas.textureNamed("star@3x.png")
        self.star.size = CGSize(width: 50, height: 50)
        self.star.alpha = 0.0
        self.star.position = CGPoint(x: (self.size.width * 0.5) - 25, y: self.size.height * 0.5)
        self.addChild(self.star)
        self.star.zPosition = self.zPosition + 1
    }
    
    func itemHit(){
        let fadeIn = SKAction.fadeIn(withDuration: 0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let position = SKAction.move(to: CGPoint(x: (self.size.width * 0.5) - 25, y: (self.size.height * 0.5) + 100), duration: 1.0)
        let group = SKAction.group([fadeIn,position])
        let seq = SKAction.sequence([group,fadeOut])
        self.star.run(seq, completion: {
            self.star.alpha = 0.0
            self.star.position = CGPoint(x: (self.size.width * 0.5) - 25, y: self.size.height * 0.5)
        })
    }

}
