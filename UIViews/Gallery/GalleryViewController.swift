//
//  GalleryViewController.swift
//  SpaceRace
//
//  Created by fernando rosa on 22/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CharactersTableViewCellDelegate, SpecialObjectsTableViewCellDelegate {
    
    var selectedItem:Any!
    var typeSelectedItem:TypeItemGaller!
    
    func characterButtonPressed(character: Int) {
        print(character)
        self.typeSelectedItem = TypeItemGaller.characters
        self.selectedItem = self.gallery.characters[0]
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    func specialObjectsButtonPressed(so: Int) {
        print(so)
        self.typeSelectedItem = TypeItemGaller.specialObject
        self.selectedItem = self.gallery.specialObjects[0]
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    
   @IBOutlet weak var tableView: UITableView!
    var gallery:Gallery! = nil
    var totalRows:Int = 0
    var storedOffsets = [Int: CGFloat]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 330.0
        }
        else
        {
            return 130.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else
        {
            let rows = Int(self.gallery.specialObjects.count/3) + (self.gallery.specialObjects.count%3 > 0 ? 1 : 0)
            self.totalRows = rows
            return rows
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCell") as! CharactersTableViewCell
            cell.initCell(characters: gallery.characters)
            cell.delegate = self
            return cell
        }else{
           let cell = tableView.dequeueReusableCell(withIdentifier: "specialObjectsCell") as! SpecialObjectsTableViewCell
            let start = (indexPath.row * 3)
            let end = (indexPath.row + 1) < self.totalRows ? (start + 3) : (self.gallery.specialObjects.count)
            cell.initCell(so: Array(self.gallery.specialObjects[start...(end-1)]))
            cell.delegate = self
            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.gallery.specialObjects[0].unlocked = true
        self.gallery.characters[0].unlocked = true
    }
    

    // MARK: - Navigation

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "goToDetails"){
              let nextViewController = segue.destination as! DetailGalleryViewController
              nextViewController.typeItem = self.typeSelectedItem
              nextViewController.item = self.selectedItem
          }
      }

}
