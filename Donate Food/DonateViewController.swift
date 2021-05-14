//
//  DonateViewController.swift
//  Donate Food
//
//  Created by Jahnae Reese 2 on 4/29/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {

    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var foodTypeField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)


    }
    
    @IBAction func onSubmit(_ sender: Any) {
        getAPIData()
    }
    
    @objc func getAPIData() {
        let time = timeField.text!
        let quantity = quantityField.text!
        let foodType = foodTypeField.text!
        
        API.postFoodRequest(pickupTime: time, foodType: foodType, quantity: quantity) { (respMessage) in
            guard let respMessage = respMessage else { return }
            let success = respMessage as! Bool
            if(success) {
                self.errorLabel.textColor = UIColor.green
                self.errorLabel.text = "Successfully posted food request"
                self.dismiss(animated: true, completion: nil)
            }
            else {
                self.errorLabel.textColor = UIColor.red
                self.errorLabel.text = "Error posting food request"
            }
        }
            
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
