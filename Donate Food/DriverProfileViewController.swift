//
//  DriverProfileViewController.swift
//  Donate Food
//
//  Created by Sahana Ilenchezhian on 5/11/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class DriverProfileViewController: UIViewController {

    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var phoneNumberField: UILabel!
    @IBOutlet weak var carDescriptionField: UILabel!
    @IBOutlet weak var pointsField: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDriverInfo()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setDriverInfo()
    }
    
    @objc func setDriverInfo(){
        API.getDriver() { (respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                let name = resp["first_name"] as? String ?? ""
                let lastName = resp["last_name"] as? String ?? ""
                self.nameField.text = "\(name) \(lastName)"
                let points = resp["reward_points"] as? String ?? "0"
                self.pointsField.text = "\(points) points"
                let carDescription = resp["car_description"] as? String ?? "N/A"
                self.carDescriptionField.text = "\(carDescription)"
                let phonenumber = resp["phone_number"] as? String ?? ""
                self.phoneNumberField.text = "\(phonenumber)"
            } else {
                print("error: API call to get driver failed!")
            }
        //                print(resp["response"]["access_token"])
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
