//
//  PlanetTableViewCell.swift
//  SpaceRace
//
//  Created by fernando rosa on 21/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var orbitImage:UIImageView!
    @IBOutlet weak var planetImage:UIImageView!
    @IBOutlet weak var labelNamePlanet:UILabel!
    @IBOutlet weak var labelLevels:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
