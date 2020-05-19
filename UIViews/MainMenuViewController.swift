//
//  MainMenuViewController.swift
//  SpaceRace
//
//  Created by fernando rosa on 20/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    
    @IBOutlet weak var storyBtn: UIButton!
    @IBOutlet weak var srvBtn: UIButton!
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var creditsBtn: UIButton!
    
    var settingsButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // CREATE A NAVIGATION CONTROLLER
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        // CUSTOMIZE BACK BUTTON
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .white
        
        // ADD SETTINGS BUTTON
        self.settingsButton = UIBarButtonItem.init(title: "", style: .plain, target: self, action: #selector(self.settingsTap(sender:)))
        self.settingsButton.image = UIImage(named: "settings")
        self.settingsButton.tintColor = .white
        self.settingsButton.isEnabled = true
        self.navigationItem.rightBarButtonItem = self.settingsButton
        
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "AvenirNext-Heavy", size: 30)!]
        
        if(GameManager.shared.isMenuMusicEnabled()){AudioManager.shared.startBackgroundMusic()}else{AudioManager.shared.stopBackgroundMusic()}
    }
    
    @objc func settingsTap(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    
    @IBAction func creditsTap(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCredits", sender: self)
    }
    
    
    @IBAction func storyTap(_ sender: Any) {
         self.performSegue(withIdentifier: "goToStory", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    

}
