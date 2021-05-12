//
//  LoginViewController.swift
//  Donate Food
//
//  Created by Matthew Kaneda on 5/6/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    

    @IBAction func loginButton(_ sender: Any) {
//        API.registerUser(email: "testemail", password: "testpassword", firstName: "fname", phoneNumber: "phoneNumber", accountType: "Driver")
        let email = emailField.text!
        let password = passwordField.text!
        
        if (email == "" || password == "") {
            statusLabel.textColor = UIColor.red
            statusLabel.text = "Cannot leave boxes empty"
        } else {
            API.loginUser(email: email, password: password) { (respPackage) in
                guard let resp = respPackage else { return }
                let success = resp["success"] as! Bool
                print(resp)
                if (success) {
                    let access_token = resp["access_token"] as! String
                    print(access_token)
                    let defaults = UserDefaults.standard
                    defaults.set(access_token, forKey: "donateapp-token")
                    
                    let is_driver = resp["is_driver"] as! Bool
                    if (is_driver) {
                        print("user is a driver")
                        defaults.set(true, forKey: "is_driver")
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let driverViewController = main.instantiateViewController(identifier: "DriverViewController")
                        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                        delegate.window?.rootViewController = driverViewController
                    } else {
                        print("user is not a driver")
                        defaults.set(false, forKey: "is_driver")
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let restaurantViewController = main.instantiateViewController(identifier: "RestaurantViewController")
                        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                        delegate.window?.rootViewController = restaurantViewController
                    }
                } else {
                    self.statusLabel.textColor = UIColor.red
                    self.statusLabel.text = "Incorrect Credentials"
                }
//                print(resp["response"]["access_token"])
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
