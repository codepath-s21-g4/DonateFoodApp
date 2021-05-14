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
    
    @objc func viewWelcomeText(){
        API.getDriver() { (respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                let access_token = resp["access_token"] as! String
                print(access_token)
                let defaults = UserDefaults.standard
                defaults.set(access_token, forKey: "donateapp-token")
                let name = resp["first_name"] as? String?
                self.welcomeTextField.text = "Welcome \(String(describing: name ?? "Driver"))"
            } else {
                print("error: API call to get driver failed!")
            }
        //                print(resp["response"]["access_token"])
        }
    }

    @IBAction func updateStatus(_ sender: Any) {
        
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
