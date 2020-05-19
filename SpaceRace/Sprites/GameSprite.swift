//
//  GameSprite.swift
//  
//
//  Created by fernando rosa on 03/11/2019.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import SpriteKit

enum PhysicsCategory:UInt32 {
       case player = 1
       case immunePlayer = 2
       case spacejunk = 4
       case bonus = 8
       case powerup = 16
       case itemToRecover = 32
       case repairFuel = 64
       case repairOxigen = 128
}

enum TypeBonus:Int{
    case oxygen = 1
    case fuel = 2
    case repairOxygen = 3
    case repairFuel = 4
    case boundary = 5
    case unkown = 6
}

enum TypeItemToRecover:Int{
    case panel = 1
    case battery = 2
    case antenna = 3
    case lens = 4
    case propeller = 5
    case unkown = 6
}

enum SizeSpaceJunk:Int{
    case small = 1
    case medium = 2
    case large = 3
    case unkown = 4
}

enum DamageType:Int{
    case oxigen = 1
    case fuel = 2
    case radar = 3
}

protocol GameSprite {
    var textureAtlas : SKTextureAtlas { get set }
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize, hasRotation: Bool, rotateDuration: TimeInterval, hasAnimationWithTexture:Bool, textureSequence:[String], timePerFrame:TimeInterval)
    func setStaticImage(name:String)
    func setAnimationWithTexture(sequence:[String], timePerFrame: TimeInterval) -> SKAction
}
