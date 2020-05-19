//
//  SettingsViewController.swift
//  SpaceRace
//
//  Created by fernando rosa on 20/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var menuMusicBtn: UIButton!
    @IBOutlet weak var tutorialBtn: UIButton!
    @IBOutlet weak var musicBtn: UIButton!
    @IBOutlet weak var effectBtn: UIButton!
    @IBOutlet weak var controlsBtn: UIButton!
    
    var musicEnable:Bool = false
    var effectsEnabled:Bool = false
    var touchEnabled:Bool = false
    var tutorialEnabled:Bool = false
    var musicMenuEnabled:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(GameManager.shared.isMusicEnabled()){
            self.musicBtn.setTitle("ON", for: .normal)
            self.musicEnable = true
        }
        else
        {
            self.musicBtn.setTitle("OFF", for: .normal)
            self.musicEnable = false
        }
        
        if(GameManager.shared.isSoundEffetsEnabled()){
            self.effectBtn.setTitle("ON", for: .normal)
            self.effectsEnabled = true
        }
        else
        {
            self.effectBtn.setTitle("OFF", for: .normal)
            self.effectsEnabled = false
        }
        
        if(GameManager.shared.isTouchEnabled()){
            self.controlsBtn.setTitle("TOUCH", for: .normal)
            self.touchEnabled = true
        }
        else
        {
            self.controlsBtn.setTitle("ACCELEROMETER", for: .normal)
            self.touchEnabled = false
        }
        
        if(GameManager.shared.isTutorialEnabled()){
               self.tutorialBtn.setTitle("ON", for: .normal)
               self.tutorialEnabled = true
           }
           else
           {
               self.tutorialBtn.setTitle("OFF", for: .normal)
               self.tutorialEnabled = false
           }
        
        if(GameManager.shared.isMenuMusicEnabled()){
            self.menuMusicBtn.setTitle("ON", for: .normal)
            self.musicMenuEnabled = true
        }
        else
        {
            self.menuMusicBtn.setTitle("OFF", for: .normal)
            self.musicMenuEnabled = false
        }
    }
    
    @IBAction func musicTap(_ sender: Any) {
        if(self.musicBtn.titleLabel?.text == "ON")
        {
            self.musicBtn.setTitle("OFF", for: .normal)
            self.musicEnable = false
        }
        else
        {
            self.musicBtn.setTitle("ON", for: .normal)
            self.musicEnable = true
        }
    }
    
    @IBAction func effectTap(_ sender: Any) {
        if(self.effectBtn.titleLabel?.text == "ON")
        {
            self.effectBtn.setTitle("OFF", for: .normal)
            self.effectsEnabled = false
        }
        else
        {
            self.effectBtn.setTitle("ON", for: .normal)
            self.effectsEnabled = true
        }
    }
    
    
    @IBAction func controlBtn(_ sender: Any) {
        if(self.controlsBtn.titleLabel?.text == "ACCELEROMETER")
        {
            self.controlsBtn.setTitle("TOUCH", for: .normal)
            self.touchEnabled = true
        }
        else
        {
            self.controlsBtn.setTitle("ACCELEROMETER", for: .normal)
            self.touchEnabled = false
        }
    }

    @IBAction func tutorialBtn(_ sender: Any) {
        if(self.tutorialBtn.titleLabel?.text == "ON")
        {
            self.tutorialBtn.setTitle("OFF", for: .normal)
            self.tutorialEnabled = false
        }
        else
        {
            self.tutorialBtn.setTitle("ON", for: .normal)
            self.tutorialEnabled = true
        }
    }
    
    @IBAction func menuMusicBtn(_ sender: Any) {
        if(self.menuMusicBtn.titleLabel?.text == "ON")
        {
            self.menuMusicBtn.setTitle("OFF", for: .normal)
            self.musicMenuEnabled = false
            AudioManager.shared.stopBackgroundMusic()
        }
        else
        {
            self.menuMusicBtn.setTitle("ON", for: .normal)
            self.musicMenuEnabled = true
            AudioManager.shared.startBackgroundMusic()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GameManager.shared.setMusicEnabled(enabled: self.musicEnable)
        GameManager.shared.setSoundEffetcsEnabled(enabled: self.effectsEnabled)
        GameManager.shared.setTouchEnabled(enabled: self.touchEnabled)
        GameManager.shared.setMenuMusicEnabled(enabled: self.musicMenuEnabled)
        GameManager.shared.setTutorialEnabled(enabled: self.tutorialEnabled)
        
        let saved = ResourceManager.shared.saveUserSettings()
        print("Saved: \(saved)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
