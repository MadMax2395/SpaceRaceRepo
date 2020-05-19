//
//  StoryViewController.swift
//  SpaceRace
//
//  Created by fernando rosa on 21/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var galleryButton:UIBarButtonItem!
    
    @IBOutlet weak var planetsTableView: UITableView!
    
    var planets:[Planet]!
    var selectedPlanet:Planet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.planets = GameManager.shared.getPlanets()
        self.planetsTableView.dataSource = self
        self.planetsTableView.delegate = self
       
        // CUSTOMIZE BACK BUTTON
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .white
        
        // ADD GALLERY BUTTON
       self.galleryButton = UIBarButtonItem.init(title: "", style: .plain, target: self, action: #selector(self.galleryTap(sender:)))
       self.galleryButton.image = UIImage(named: "gallery")
       self.galleryButton.tintColor = .yellow
       self.galleryButton.isEnabled = true
       self.navigationItem.rightBarButtonItem = self.galleryButton
        
        
    }
    
    @objc func galleryTap(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToGallery", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return self.planets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "introCell")!
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell") as! PlanetTableViewCell
            cell.planetImage.image = UIImage(named: self.planets[indexPath.item].image)
            cell.labelNamePlanet.text = self.planets[indexPath.item].name.uppercased()
            cell.labelLevels.text = "Level complete 0/\(self.planets[indexPath.item].levels.count)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            self.selectedPlanet = self.planets[indexPath.row]
            self.performSegue(withIdentifier: "goToLevels", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToLevels"){
            let nextViewController = segue.destination as! PlanetViewController
            nextViewController.planet = self.selectedPlanet
        }
        if(segue.identifier == "goToGallery"){
            let nextViewController = segue.destination as! GalleryViewController
            let gallery:Gallery = Gallery(charactersDict: GameManager.shared.getCharactersGalleryData(), specialObjectsDict: GameManager.shared.getSpecialObjectsGalleryData())
            nextViewController.gallery = gallery
        }
    }
    

}
