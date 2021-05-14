//
//  acceptRequestViewController.swift
//  Donate Food
//
//  Created by Jahnae Reese 2 on 5/14/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit




class acceptRequestViewController: UIViewController {
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var ETA: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func onAccept(_ sender: Any) {
        getAPIData()
    }
    
    @objc func getAPIData() {
        let shelter = destinationField.text!
        let DriverETA = ETA.text!
        let name = restaurantName.text!
    
        API.acceptFoodRequest(restaurantName: name, shelter: shelter, DriverETA: DriverETA) { (restaurant) in
            guard let restaurant = restaurant else { return }
            let success = restaurant as! Bool
            if(success) {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                
            }
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
