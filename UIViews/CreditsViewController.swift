//
//  CreditsViewController.swift
//  SpaceRace
//
//  Created by fernando rosa on 21/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

enum People:Int {
    case rob = 1
    case massimo = 2
    case simona = 3
    case simone = 4
    case fernando = 5
    case michele = 6
}

class CreditsViewController: UIViewController {

    var imageName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageName = ""
    }
    
   
    @IBAction func tapButton(_ sender: Any) {
        switch (sender as! UIButton).tag {
        case People.simona.rawValue:
            self.imageName = "creditsSimona"
        case People.simone.rawValue:
            self.imageName = "creditsSimone"
        case People.rob.rawValue:
            self.imageName = "creditsRob"
        case People.fernando.rawValue:
            self.imageName = "creditsFer"
        case People.michele.rawValue:
            self.imageName = "creditsMike"
        case People.massimo.rawValue:
            self.imageName = "creditsMax"
        default:
            self.imageName = "creditsSimona"
        }
        
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! CreditsDetailsViewController
        nextViewController.imageName = self.imageName
    }
    

}
