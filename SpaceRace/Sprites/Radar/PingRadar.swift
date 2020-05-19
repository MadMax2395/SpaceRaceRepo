//
//  PingRadar.swift
//  SpaceRace
//
//  Created by fernando rosa on 12/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import SpriteKit

enum PingType{
    case malus
    case bonus
    case pieceToRecover
    case unknow
    case player
}

class PingRadar: SKSpriteNode{
    var type: PingType!
    var pingColor: UIColor!
    var dot:SKShapeNode!
    var pingName:String!
    
    func initPing(type:PingType, pingName:String){
        self.type = type
        switch self.type {
        case .malus:
            self.pingColor = UIColor.red
            break
        case .bonus:
            self.pingColor = UIColor.blue
            break
        case .pieceToRecover:
            self.pingColor = UIColor.green
            break
        case .player:
            self.pingColor = UIColor.white
        case .unknow:
            self.pingColor = UIColor.cyan
            break
        default:
            self.pingColor = UIColor.cyan
        }
        
        self.pingName = pingName
        self.size = CGSize(width: 2, height: 2)
        self.dot = SKShapeNode(circleOfRadius: 2)
        self.dot.fillColor = self.pingColor
        self.dot.strokeColor = self.pingColor
        self.addChild(self.dot)
        self.dot.zPosition = self.zPosition + 1
        
    }
}
