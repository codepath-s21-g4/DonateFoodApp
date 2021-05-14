//
//  RestaurantProfileViewController.swift
//  Donate Food
//
//  Created by Jahnae Reese 2 on 4/29/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class RestaurantProfileViewController: UIViewController {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!

    
    
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
            self.phoneNumber.text = restaurant["phone_number"] as? String
            self.address.text = restaurant["address"] as? String
            
            
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
