//
//  editRestaurantProfileViewController.swift
//  Donate Food
//
//  Created by Jahnae Reese 2 on 5/14/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class editRestaurantProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSave(_ sender: Any) {
        getAPIData()
    }
    
    @objc func getAPIData() {
        let name = nameTextField.text!
        let phone = phoneTextField.text!
        let address = addressTextField.text!
        
        API.editRestaurantProfile(name: name, phoneNumber: phone, address: address) { (restaurant) in
            guard let restaurant = restaurant else {
                return
            }
            let success = restaurant as! Bool
            if(success) {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("Error editing profile")
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
