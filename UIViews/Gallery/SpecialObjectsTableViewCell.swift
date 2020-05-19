//
//  SpecialObjectsTableViewCell.swift
//  SpaceRace
//
//  Created by fernando rosa on 24/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

protocol SpecialObjectsTableViewCellDelegate {
    func specialObjectsButtonPressed(so:Int)
}

class SpecialObjectsTableViewCell: UITableViewCell {

    var delegate: SpecialObjectsTableViewCellDelegate?
    var selectedSO:Int = -1
    
    @IBOutlet var specialObject1: UIImageView!
    @IBOutlet var specialObjectBtn1: UIButton!
    @IBOutlet var specialObjectLabel1: UILabel!
    
    @IBOutlet var specialObject2: UIImageView!
    @IBOutlet var specialObjectBtn2: UIButton!
    @IBOutlet var specialObjectLabel2: UILabel!
    
    @IBOutlet var specialObject3: UIImageView!
    @IBOutlet var specialObjectBtn3: UIButton!
    @IBOutlet var specialObjectLabel3: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func soTap(_ sender: Any) {
        self.selectedSO = (sender as! UIButton).tag
        self.delegate?.specialObjectsButtonPressed(so:self.selectedSO)
    }
    
    func initCell(so:[SpecialObject]) {
        for index in 0 ..< so.count{
            if(so[index].unlocked){
                self.specialObject1.image = UIImage(named: so[index].image)
                self.specialObjectLabel1.text = so[index].name.uppercased()
                self.specialObjectBtn1.isHidden = false
                self.specialObjectBtn1.tag = 1
            }
        }
    }
}
