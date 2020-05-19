//
//  LevelsTableViewCell.swift
//  SpaceRace
//
//  Created by fernando rosa on 22/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

protocol LevelsTableViewCellDelegate {
    func levelButtonPressed(level:Int)
}

class LevelsTableViewCell: UITableViewCell {

    var delegate: LevelsTableViewCellDelegate?
    
    var selectedLevel:Int = -1
    
    @IBOutlet weak var level1: UIView!
    @IBOutlet weak var btnLevel1: UIButton!
    @IBOutlet weak var phLevel1: UIImageView!
    @IBOutlet weak var bgLevel1: UIImageView!
    @IBOutlet weak var characterLevel1: UIImageView!
    @IBOutlet weak var characterNameLevel1: UILabel!
    @IBOutlet weak var starsLevel1: UIImageView!
    
    @IBOutlet weak var level2: UIView!
    @IBOutlet weak var btnLevel2: UIButton!
    @IBOutlet weak var phLevel2: UIImageView!
    @IBOutlet weak var bgLevel2: UIImageView!
    @IBOutlet weak var characterLevel2: UIImageView!
    @IBOutlet weak var characterNameLevel2: UILabel!
    @IBOutlet weak var starsLevel2: UIImageView!
    
    @IBOutlet weak var level3: UIView!
    @IBOutlet weak var btnLevel3: UIButton!
    @IBOutlet weak var bgLevel3: UIImageView!
    @IBOutlet weak var phLevel3: UIImageView!
    @IBOutlet weak var characterLevel3: UIImageView!
    @IBOutlet weak var characterNameLevel3: UILabel!
    @IBOutlet weak var starsLevel3: UIImageView!
    
    
    
    @IBAction func levelTap(_ sender: Any) {
        self.selectedLevel = (sender as! UIButton).tag
        self.delegate?.levelButtonPressed(level:self.selectedLevel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell(levels:[Level]) {
        if levels.count == 1 {
            self.btnLevel1.isHidden = true
            self.level1.isHidden = true
            self.btnLevel3.isHidden = true
            self.level3.isHidden = true
            
            if(levels[0].mission.characterName != "unknown"){
                self.btnLevel2.tag = levels[0].number
                self.characterLevel2.image = UIImage(named: levels[0].mission.characterName)
                self.characterNameLevel2.text = levels[0].mission.characterName.uppercased()
            }else{
                self.characterLevel2.isHidden = true
                self.characterNameLevel2.isHidden = true
                self.btnLevel2.isHidden = true
                self.starsLevel2.isHidden = true
                self.phLevel2.isHidden = true
                self.bgLevel2.image = UIImage(named: levels[0].mission.characterName)
            }
            
            
        }
        else if levels.count == 2 {
            self.btnLevel2.isHidden = true
            self.level2.isHidden = true
            
            if(levels[0].mission.characterName != "unknown"){
                self.btnLevel1.tag = levels[0].number
                self.characterLevel1.image = UIImage(named: levels[0].mission.characterName)
                self.characterNameLevel1.text = levels[0].mission.characterName.uppercased()
            }else{
                self.characterLevel1.isHidden = true
                self.characterNameLevel1.isHidden = true
                self.btnLevel1.isHidden = true
                self.starsLevel1.isHidden = true
                self.phLevel1.isHidden = true
                self.bgLevel1.image = UIImage(named: levels[0].mission.characterName)
            }
            
            if(levels[1].mission.characterName != "unknown"){
                self.btnLevel3.tag = levels[1].number
                self.characterLevel3.image = UIImage(named: levels[1].mission.characterName)
                self.characterNameLevel3.text = levels[1].mission.characterName.uppercased()
            }else{
                self.characterLevel3.isHidden = true
                self.characterNameLevel3.isHidden = true
                self.btnLevel3.isHidden = true
                self.starsLevel3.isHidden = true
                self.phLevel3.isHidden = true
                self.bgLevel3.image = UIImage(named: levels[1].mission.characterName)
            }
            
            
        }
        else {
            if(levels[0].mission.characterName != "unknown"){
                 self.btnLevel1.tag = levels[0].number
                 self.characterLevel1.image = UIImage(named: levels[0].mission.characterName)
                 self.characterNameLevel1.text = levels[0].mission.characterName.uppercased()
            }else{
                self.characterLevel1.isHidden = true
                self.characterNameLevel1.isHidden = true
                self.btnLevel1.isHidden = true
                self.starsLevel1.isHidden = true
                self.phLevel1.isHidden = true
                self.bgLevel1.image = UIImage(named: levels[0].mission.characterName)
            }
            
            if(levels[1].mission.characterName != "unknown"){
                 self.btnLevel2.tag = levels[1].number
                 self.characterLevel2.image = UIImage(named: levels[1].mission.characterName)
                 self.characterNameLevel2.text = levels[1].mission.characterName.uppercased()
            }else{
                self.characterLevel2.isHidden = true
                self.characterNameLevel2.isHidden = true
                self.btnLevel2.isHidden = true
                self.starsLevel2.isHidden = true
                self.phLevel2.isHidden = true
                self.bgLevel2.image = UIImage(named: levels[1].mission.characterName)
            }
            
            if(levels[2].mission.characterName != "unknown"){
                 self.btnLevel3.tag = levels[2].number
                 self.characterLevel3.image = UIImage(named: levels[2].mission.characterName)
                 self.characterNameLevel3.text = levels[2].mission.characterName.uppercased()
            }else{
                self.characterLevel3.isHidden = true
                self.characterNameLevel3.isHidden = true
                self.btnLevel3.isHidden = true
                self.starsLevel3.isHidden = true
                self.phLevel3.isHidden = true
                self.bgLevel3.image = UIImage(named: levels[2].mission.characterName)
            }
           
           
            
        }
    }

}
