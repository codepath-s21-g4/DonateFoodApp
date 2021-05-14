//
//  EditDriverProfileViewController.swift
//  Donate Food
//
//  Created by Sahana Ilenchezhian on 5/14/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class EditDriverProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var carDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setPlaceholderInfo()
    }
    
    @objc func setPlaceholderInfo(){
        API.getDriver() { (respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                let name = resp["first_name"] as? String ?? ""
                self.nameTextField.text = "\(name)"
                let carDescription = resp["car_description"] as? String ?? ""
                self.carDescriptionTextField.text = "\(carDescription)"
                let phonenumber = resp["phone_number"] as! String
                print(phonenumber)
                self.phoneTextField.text = "\(phonenumber)"
            } else {
                print("error: API call to get driver failed!")
            }
        //                print(resp["response"]["access_token"])
        }
    }
    
    @objc func updateDriverInfo(){
        let name = nameTextField.text!
        let phoneNumber = phoneTextField.text!
        let carDescription = carDescriptionTextField.text!
        API.updateDriver(name: name, phoneNumber: phoneNumber, carDescription: carDescription){ (respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error: API call to get driver failed!")
            }
        //                print(resp["response"]["access_token"])
            
        }
    }
    @IBAction func updateDriverProfile(_ sender: Any) {
        updateDriverInfo()
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
