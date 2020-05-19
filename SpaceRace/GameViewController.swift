//
//  GameViewController.swift
//
//
//  Created by fernando rosa on 31/10/2019.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



class GameViewController: UIViewController, GameSceneDelegate {

    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var continueGameBtn: UIButton!
    @IBOutlet weak var musicBtn: UIButton!
    @IBOutlet weak var effectsBtn: UIButton!
    @IBOutlet weak var controlsBtn: UIButton!
    
    
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var tutorial: UIImageView!
    var tutorialImage:[String] = ["tutorial0","tutorial1","tutorial2","tutorial3","tutorial4"]
    var index:Int = 0
    var selectedLevel:Level!
    var gameScene:GameScene!
    
    
    @IBOutlet weak var endMissionView: UIView!
    @IBOutlet weak var endMissionImagine: UIImageView!
    @IBOutlet weak var endMissionPlanetImagine: UIImageView!
    @IBOutlet weak var endMissionStarsImagine: UIImageView!
    @IBOutlet weak var endMissionLabel: UILabel!
    @IBOutlet weak var endMissionMsgLabel: UILabel!
    @IBOutlet weak var endMissionButton: UIButton!
    @IBOutlet weak var endMissionSecondButton: UIButton!
    @IBOutlet weak var endMissionFirstStarImagine: UIImageView!
    @IBOutlet weak var endMissionSecondStarImagine: UIImageView!
    @IBOutlet weak var endMissionThirdStarImagine: UIImageView!
    
    @IBAction func endMissionOkTap(_ sender: Any) {
        self.gameScene.isPaused = true
        self.gameScene.leaveLEvel()
        self.navigationController?.popViewController(animated: true)
    }
    
    func setStars(){
        self.endMissionFirstStarImagine.alpha = 0
        self.endMissionSecondStarImagine.alpha = 0
        self.endMissionThirdStarImagine.alpha = 0
    }
    
    func showStars(numberOfStars:Int){
        UIView.animate(withDuration: 0.5, animations: {
            self.endMissionFirstStarImagine.alpha = 1
        }, completion: {  (finished: Bool) in
            if (numberOfStars >= 2) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.endMissionSecondStarImagine.alpha = 1
                }, completion: {  (finished: Bool) in
                    if (numberOfStars == 3){
                        UIView.animate(withDuration: 0.5, animations: {
                            self.endMissionThirdStarImagine.alpha = 1
                        })
                    }
                })
            }
        })
    }
    
    func endMission(endType: TypeEndMission) {
        
           self.tutorial.isHidden = true
           self.pauseBtn.isHidden = true
           let  blur = CIFilter(name:"CIGaussianBlur",parameters: ["inputRadius": 10.0])
           self.gameScene.filter = blur
           self.gameScene.shouldRasterize = true
           self.gameScene.shouldEnableEffects = true
           self.gameScene.isPaused = true
        switch endType {
        case TypeEndMission.endFuel:
            self.endMissionImagine.image = UIImage(named:"fuel")
            self.endMissionLabel.text = "MISSION FAILED"
            self.endMissionStarsImagine.isHidden = true
            self.endMissionSecondButton.setTitle("MENU", for: .normal)
            self.endMissionMsgLabel.text = "You have no more fuel!"
            self.endMissionButton.setTitle("RETRY", for: .normal)
        case TypeEndMission.endOxigen:
            self.endMissionImagine.image = UIImage(named:"oxygen")
            self.endMissionLabel.text = "MISSION FAILED"
            self.endMissionStarsImagine.isHidden = true
            self.endMissionSecondButton.setTitle("MENU", for: .normal)
            self.endMissionMsgLabel.text = "You have no more oxygen!"
            self.endMissionButton.setTitle("RETRY", for: .normal)
        case TypeEndMission.outOfBoundary:
            self.endMissionImagine.image = UIImage(named:"outboundary")
            self.endMissionLabel.text = "MISSION FAILED"
            self.endMissionStarsImagine.isHidden = true
            self.endMissionSecondButton.setTitle("MENU", for: .normal)
            self.endMissionMsgLabel.text = "Huston we have a problem!"
            self.endMissionButton.setTitle("RETRY", for: .normal)
        case TypeEndMission.endWin:
            self.setStars()
            self.endMissionImagine.image = UIImage(named:"salyut1Char")
            self.endMissionLabel.text = "MISSION COMPLETE!"
            self.endMissionStarsImagine.isHidden = false
            self.endMissionFirstStarImagine.isHidden = false
            self.endMissionSecondStarImagine.isHidden = false
            self.endMissionThirdStarImagine.isHidden = false
            self.endMissionSecondButton.setTitle("RETRY", for: .normal)
            self.endMissionMsgLabel.text = "Great work!"
            self.endMissionButton.setTitle("CONTINUE", for: .normal)
        default:
            self.endMissionImagine.image = UIImage(named:"oxygen")
            self.endMissionLabel.text = "MISSION FAILED"
        }
        
           UIView.animate(withDuration: 0.5, animations: {
               self.endMissionView.alpha = 1
           },completion: {  (finished: Bool) in
                if (endType == TypeEndMission.endWin){
                    self.showStars(numberOfStars: 3)
                }
           })
       }
    
    @IBOutlet weak var gameView: SKView!
    
    override func viewWillLayoutSubviews() {
        self.pauseView.alpha = 0.0
        self.pauseView.layer.cornerRadius = 10
        
        self.endMissionView.alpha = 0.0
        self.endMissionView.layer.cornerRadius = 10
        
        super.viewWillLayoutSubviews()
        
        self.musicBtn.setTitle(GameManager.shared.isMusicEnabled() ? "ON" : "OFF", for: .normal)
        self.effectsBtn.setTitle(GameManager.shared.isSoundEffetsEnabled() ? "ON" : "OFF", for: .normal)
        self.controlsBtn.setTitle(GameManager.shared.isTouchEnabled() ? "TOUCH" : "ACCELEROMETER", for: .normal)
        AudioManager.shared.stopBackgroundMusic()
        
        
        if(GameManager.shared.isTutorialEnabled()){
            self.tutorial.image = UIImage(named: self.tutorialImage[index])
            self.tutorial.isHidden = false
            self.continueBtn.isHidden = false
            self.viewBtn.isHidden = false
            self.pauseBtn.isHidden = true
           
        }
        else
        {
            self.tutorial.isHidden = true
            self.continueBtn.isHidden = true
            self.viewBtn.isHidden = true
            self.pauseBtn.isHidden = false
            self.gameScene = GameScene()
            self.gameScene.setDataLevel(level: selectedLevel.number)
            self.gameScene.gameDelegate = self
            
            
            let skView = self.gameView as! SKView
            // Ignore drawing order of child nodes
            // (This increases performance)
            skView.ignoresSiblingOrder = true
            // Size our scene to fit the view exactly:
            gameScene.size = gameView.bounds.size
            // Show the menu:
            skView.presentScene(self.gameScene)
        }
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(GameManager.shared.isMenuMusicEnabled()){AudioManager.shared.startBackgroundMusic()}else{AudioManager.shared.stopBackgroundMusic()}
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func continueTap(_ sender: Any) {
        if(self.index < 4){
            self.index += 1
            self.tutorial.image = UIImage(named: self.tutorialImage[index])
            if(self.index == 4){
                self.continueBtn.setTitle("Play", for: .normal)
            }
        }else if (self.index == 4){
           self.tutorial.isHidden = true
           self.continueBtn.isHidden = true
           self.viewBtn.isHidden = true
           self.pauseBtn.isHidden = false
           self.gameScene = GameScene()
           self.gameScene.setDataLevel(level: selectedLevel.number)
           self.gameScene.gameDelegate = self
           let skView = self.gameView as! SKView
           // Ignore drawing order of child nodes
           // (This increases performance)
           skView.ignoresSiblingOrder = true
           // Size our scene to fit the view exactly:
           gameScene.size = gameView.bounds.size
           // Show the menu:
           skView.presentScene(gameScene)
        }
    }
    
    @IBAction func pauseBtn(_ sender: Any) {
        self.pauseBtn.isHidden = true
        let  blur = CIFilter(name:"CIGaussianBlur",parameters: ["inputRadius": 10.0])
        self.gameScene.filter = blur
        self.gameScene.shouldRasterize = true
        self.gameScene.shouldEnableEffects = true
        self.gameScene.isPaused = true
        UIView.animate(withDuration: 0.5, animations: {
            self.pauseView.alpha = 1
        })
    }
    
    @IBAction func exitTap(_ sender: Any) {
        self.gameScene.isPaused = true
        self.gameScene.leaveLEvel()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueGameTap(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.pauseView.alpha = 0
        }, completion: {  (finished: Bool) in
            self.gameScene.shouldEnableEffects = false
            self.gameScene.isPaused = false
            if(GameManager.shared.isMusicEnabled()){self.gameScene.playMusic()}else{self.gameScene.stopMusic()}
            self.pauseBtn.isHidden = false
        })
    }
    
    @IBAction func retryGameTap(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.endMissionView.alpha = 0
        }, completion: {  (finished: Bool) in
            self.gameScene.resetAndRetry()
            self.gameScene.shouldEnableEffects = false
            self.gameScene.isPaused = false
            if(GameManager.shared.isMusicEnabled()){self.gameScene.playMusic()}else{self.gameScene.stopMusic()}
            self.pauseBtn.isHidden = false
        })
    }
    
    @IBAction func controlTap(_ sender: Any) {
        if(self.controlsBtn.titleLabel?.text == "ACCELEROMETER")
        {
            self.controlsBtn.setTitle("TOUCH", for: .normal)
            GameManager.shared.setTouchEnabled(enabled: true)
            self.gameScene.touchActive = true
        }
        else
        {
            self.controlsBtn.setTitle("ACCELEROMETER", for: .normal)
            GameManager.shared.setTouchEnabled(enabled: false)
            self.gameScene.touchActive = false
            self.gameScene.first = true
        }
    }
    
    @IBAction func musicTap(_ sender: Any) {
        if(self.musicBtn.titleLabel?.text == "ON")
        {
            self.musicBtn.setTitle("OFF", for: .normal)
            GameManager.shared.setMusicEnabled(enabled: false)
            self.gameScene.stopMusic()
        }
        else
        {
            self.musicBtn.setTitle("ON", for: .normal)
            GameManager.shared.setMusicEnabled(enabled: true)
            self.gameScene.playMusic()
        }
    }
    
    @IBAction func effectsTAP(_ sender: Any) {
        if(self.effectsBtn.titleLabel?.text == "ON")
        {
            self.effectsBtn.setTitle("OFF", for: .normal)
            GameManager.shared.setSoundEffetcsEnabled(enabled: false)
        }
        else
        {
            self.effectsBtn.setTitle("ON", for: .normal)
            GameManager.shared.setSoundEffetcsEnabled(enabled: true)
        }
    }
    
    
    
}
