//
//  SceneDelegate.swift
//  Donate Food
//
//  Created by Sahana Ilenchezhian on 4/15/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let defaults = UserDefaults.standard

        if let name = defaults.object(forKey: "donateapp-token") {
            print("token on app start: ", name)
            if let is_driver = defaults.object(forKey: "is_driver"){
                print("is_driver: \(is_driver)")
                let is_driver = is_driver as! Bool
                
                if (is_driver) {
                    let main = UIStoryboard(name: "Main", bundle: nil)
                    let driverViewController = main.instantiateViewController(identifier: "DriverViewController")
                    window?.rootViewController = driverViewController
                } else {
                    let main = UIStoryboard(name: "Main", bundle: nil)
                    let restaurantViewController = main.instantiateViewController(identifier: "RestaurantViewController")
                    window?.rootViewController = restaurantViewController
                }
                
            } else {
                let main = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
                window?.rootViewController = loginViewController
            }
//            let main = UIStoryboard(name: "Main", bundle: nil)
//            let dashboard = main.instantiateViewController(identifier: <#T##String#>)
        } else {
            print("no token available on app start")
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
            window?.rootViewController = loginViewController
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

