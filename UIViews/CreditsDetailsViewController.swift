//
//  CreditsDetailsViewController.swift
//  SpaceRace
//
//  Created by fernando rosa on 22/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class CreditsDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: self.imageName)
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
