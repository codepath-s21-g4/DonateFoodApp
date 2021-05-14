//
//  DriverHomeViewController.swift
//  Donate Food
//
//  Created by Sahana Ilenchezhian on 5/11/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class DriverHomeViewController: UIViewController {

    @IBOutlet weak var welcomeTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewWelcomeText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewWelcomeText()
    }
    
    @objc func viewWelcomeText(){
        API.getDriver() { (respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                let name = resp["first_name"] as? String ?? "Driver"
                self.welcomeTextField.text = "Welcome \(name)!"
            } else {
                print("error: API call to get driver failed!")
            }
        //                print(resp["response"]["access_token"])
        }
    }

    @IBAction func updateStatus(_ sender: Any) {
        
    }
    
    @IBAction func onLogout(_ sender: Any) {

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
