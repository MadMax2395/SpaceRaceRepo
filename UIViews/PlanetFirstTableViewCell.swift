//
//  PlanetFirstTableViewCell.swift
//  SpaceRace
//
//  Created by fernando rosa on 22/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class PlanetFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetDescriptionLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
