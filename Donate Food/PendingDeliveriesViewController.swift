//
//  PendingDeliveriesViewController.swift
//  Donate Food
//
//  Created by Sahana Ilenchezhian on 5/14/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class PendingDeliveriesViewController: UIViewController {

    @IBOutlet weak var RestaurantLabel: UILabel!
    @IBOutlet weak var ShelterLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var updatedStatusTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getActiveRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getActiveRequest()
    }
    
    @objc func getActiveRequest(){
        API.getPendingDelivery() { (respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                guard let food_request = resp["food_request"] as? [String: Any] else {return}
                guard let restaurant_obj = food_request["restaurant"] as? [String: Any] else {return}
                let restaurant = restaurant_obj["name"] as? String ?? ""
                self.RestaurantLabel.text = restaurant
                
                let shelter = food_request["shelter"] as? String ?? ""
                self.ShelterLabel.text = shelter
                
                let status = food_request["status"] as? String ?? ""
                self.StatusLabel.text = status
                
            } else {
                print("error: API call to get request failed!")
            }
        //                print(resp["response"]["access_token"])
        }
    }
    @objc func updateDeliveryStatus(status: String){
        API.updateStatus(status: status){(respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                self.getActiveRequest()
            } else {
                print("error: API call to update status failed!")
            }
            
        }
    }
    @IBAction func updateStatus(_ sender: Any) {
        let newStatus = updatedStatusTextField.text!
        self.updateDeliveryStatus(status: newStatus)
    }
    
    @IBAction func completedRequest(_ sender: Any) {
        API.completeDelivery(){(respPackage) in
            guard let resp = respPackage else { return }
            let success = resp["success"] as! Bool
            print(resp)
            if (success) {
                self.updateDeliveryStatus(status: "Completed")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error: API call to update status failed!")
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
