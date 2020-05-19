//
//  AppDelegate.swift
//  SpaceRace
//
//  Created by fernando rosa on 04/11/2019.
//  Copyright © 2019 fernando rosa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let userSettings:NSDictionary = ResourceManager.shared.loadUserSettings() ?? NSDictionary()
        GameManager.shared.setSettingsFromLocalData(useTouch: userSettings["useTouch"] as! Bool, useMusic: userSettings["useMusic"] as! Bool, useSoundEffetcs: userSettings["useSoundEffetcs"] as! Bool, useTutorial: userSettings["useTutorial"] as! Bool, useMenuMusic: userSettings["useMenuMusic"] as! Bool)
        
        let planetsData:NSDictionary = ResourceManager.shared.loadPlanetsData() ?? NSDictionary()
        GameManager.shared.setPlanetsData(data: planetsData)
        
        let galleryData:NSDictionary = ResourceManager.shared.loadGalleryData() ?? NSDictionary()
        GameManager.shared.setGalleryData(data: galleryData)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

