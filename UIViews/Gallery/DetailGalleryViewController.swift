//
//  DetailGalleryViewController.swift
//  SpaceRace
//
//  Created by fernando rosa on 25/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

enum TypeItemGaller:Int{
    case characters = 1
    case specialObject = 2
}

class DetailGalleryViewController: UIViewController {

    var typeItem:TypeItemGaller = TypeItemGaller.characters
    var item:Any!
    
    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var nameDetail: UILabel!
    @IBOutlet var descriptionDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.typeItem == TypeItemGaller.characters){
            self.detailImage.image = UIImage(named: (self.item as! Character).imageDetail)
            self.nameDetail.text = (self.item as! Character).name
            self.descriptionDetail.text = (self.item as! Character).description
        }
        else  if(self.typeItem == TypeItemGaller.specialObject){
            self.detailImage.image = UIImage(named: (self.item as! SpecialObject).image)
            self.nameDetail.text = (self.item as! SpecialObject).name
            self.descriptionDetail.text = (self.item as! SpecialObject).description
        }
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
