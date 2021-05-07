//
//  LoginViewController.swift
//  Donate Food
//
//  Created by Matthew Kaneda on 5/6/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginButton(_ sender: Any) {
        API.registerUser(email: "testemail", password: "testpassword", firstName: "fname", phoneNumber: "lname", accountType: "Driver")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
