//
//  GameOverScene.swift
//  SpaceRace
//
//  Created by Simone Punzo on 18/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import Foundation
import SpriteKit

//class GameOverScene : SKScene{
//    let won:Bool
//    init(size: CGSize, won: Bool)
//    {
//        self.won = won
//        super.init(size: size) }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//      }
//
//   override func didMove(to view: SKView) {
//      var backgroundGameOver: SKSpriteNode
//      if (won)
//    {
//    backgroundGameOver = SKSpriteNode(imageNamed: "YouWin") qui c'è da mettere l'immagine di mission cleared ed eventualmente un suono
//        run(SKAction.playSoundFileNamed("win.wav",
//            waitForCompletion: false))
//
//      } else {
//  qui c'è da mettere l'immagine di mission failed ed eventualmente un suono
//    backgroundGameOver = SKSpriteNode(imageNamed: "YouLose")
//        run(SKAction.playSoundFileNamed("lose.wav",
//            waitForCompletion: false))
//      }
//    backgroundGameOver.position = CGPoint(x: size.width/2, y: size.height/2)
//    self.addChild(backgroundGameOver)
//  questo fa transitare direttamente al menu dopo aver vinto o perso unamissione
//    let wait = SKAction.wait(forDuration: 3.0)
//    let block = SKAction.run {
//    let myScene = MenuScene(size: self.size)
//    myScene.scaleMode = self.scaleMode
//    let reveal = SKTransition.fade(withDuration: 0.5)
//        self.view?.presentScene(myScene, transition: reveal)
//    }
//    self.run(SKAction.sequence([wait, block]))
//    }
//
//}
