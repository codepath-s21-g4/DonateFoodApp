//
//  API.swift
//  Donate Food
//
//  Created by Jahnae Reese 2 on 5/6/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import Foundation
import UIKit
struct API {
    static func getPickups() {

        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }

            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }

            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }

        }
        task.resume()
    }
    
    static func registerUser(email: String, password: String, firstName: String, phoneNumber: String, accountType: String) {
        
        let dataToSend: [String: Any] = ["email": email, "password": password, "first_name": firstName, "phone_number": phoneNumber, "account_type": accountType]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dataToSend)
        
        guard let url = URL(string: ProcessInfo.processInfo.environment["DATABASE_URL"]! + "/driver/create-new-driver") else { fatalError() }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string: \(dataString)")
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                print("dataDictionary: ", dataDictionary)
                
                print("response: ", response)
                
                
            }
        }
        task.resume()
        
    }
    
}
