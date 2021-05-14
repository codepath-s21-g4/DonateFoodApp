//
//  RestaurantHomeViewController.swift
//  Donate Food
//
//  Created by Jahnae Reese 2 on 4/29/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class RestaurantHomeViewController: UIViewController {

    
    @IBOutlet weak var listFoodBtn: UIButton!
    @IBOutlet weak var viewDriverBtn: UIButton!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var shelterName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var ETA: UILabel!
    @IBOutlet weak var restaurantHomeName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getAPIData()
    }
    
    @objc func getAPIData() {
        API.getRestaurantInfo { (restaurant) in
            guard let restaurant = restaurant else {
                return
            }
            
            self.restaurantName.text = restaurant["name"] as? String
            self.shelterName.text = restaurant["shelter"] as? String
            self.status.text = restaurant["status"] as? String
            self.ETA.text = restaurant["driver_eta_restaurant"] as? String
            self.restaurantHomeName.text = restaurant["name"] as? String
        }
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        
        print("logout button pressed")
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "donateapp-token")
        defaults.removeObject(forKey: "is_driver")
        
        if let name = defaults.object(forKey: "donateapp-token") {
            // JWT token still here
            print("still has token ")
        } else {
            // redirect to login screen
            print("token not found")
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
            let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            delegate.window?.rootViewController = loginViewController
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
