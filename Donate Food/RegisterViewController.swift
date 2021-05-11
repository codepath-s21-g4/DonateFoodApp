//
//  RegisterViewController.swift
//  Donate Food
//
//  Created by Matthew Kaneda on 5/6/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var fnameField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    @IBOutlet weak var accountTypeField: UISegmentedControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nameRenderSwitch(_ sender: Any) {
        let types = ["Restaurant", "Driver"]
        let nameRender = types[accountTypeField.selectedSegmentIndex]
        
        if (nameRender == "Restaurant") {
            nameLabel.text = "Restaurant Name:"
        }
        if (nameRender == "Driver") {
            nameLabel.text = "First Name:"
        }
    }
    @IBAction func registerButton(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        let firstName = fnameField.text!
        let phoneNumber = phoneNumField.text!
        
        let types = ["Restaurant", "Driver"]
        let accountType = types[accountTypeField.selectedSegmentIndex]
        
        if (email == "") || (password == "") || (firstName == "") || (phoneNumber == "") {
            errorLabel.textColor = UIColor.red
            errorLabel.text = "Cannot leave boxes empty"
        } else {
            
            print(email, password, firstName, phoneNumber, accountType)
            
            API.registerUser(email: email, password: password, firstName: firstName, phoneNumber: phoneNumber, accountType: accountType) { (respMessage) in
                guard let respMessage = respMessage else { return }
    //            self.errorLabel.text = respMessage
                if (respMessage) {
                    self.errorLabel.textColor = UIColor.green
                    self.errorLabel.text = "Successfully created account"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
                        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                        delegate.window?.rootViewController = loginViewController
                    }
                } else {
                    self.errorLabel.textColor = UIColor.red
                    self.errorLabel.text = "Error creating account"
                }
            }
        }
        
        // Should only render this if there was an error
        
//        errorLabel.text = "Error registering user. Please try again"
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
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
