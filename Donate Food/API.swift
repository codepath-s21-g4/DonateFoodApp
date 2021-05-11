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
    
    static func registerUser(email: String, password: String, firstName: String, phoneNumber: String, accountType: String, completionHandler: @escaping (Bool?) -> Void){
        
        var urlString = ""
        var dataToSend: [String:Any] = ["email": "", "password": ""]
        
        if (accountType == "Driver") {
            urlString = ProcessInfo.processInfo.environment["DATABASE_URL"]! + "/driver/create-new-driver"
            dataToSend = ["email": email, "password": password, "first_name": firstName, "phone_number": phoneNumber]
        } else if (accountType == "Restaurant") {
            urlString = ProcessInfo.processInfo.environment["DATABASE_URL"]! + "/restaurant/create-new-restaurant"
            dataToSend = ["email": email, "password": password, "name": firstName, "phone_number": phoneNumber]
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dataToSend )
        guard let url = URL(string: urlString) else { fatalError() }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if (response.statusCode != 200) {
                    return completionHandler(false)
                }
            }
            if let error = error {
                print(error.localizedDescription)
                
                return completionHandler(false)
            } else if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string: \(dataString)")

                return completionHandler(true)
            }

        }
        task.resume()
        
    }
    
    static func loginUser(email: String, password: String, completionHandler: @escaping ([String:Any]?)->Void) {
        
        let dataToSend: [String:Any] = ["email": email, "password": password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dataToSend )
        
        guard let url = URL(string: ProcessInfo.processInfo.environment["DATABASE_URL"]! + "/auth") else { fatalError() }
        var request = URLRequest(url: url)
        
        print("jsonData: \(dataToSend)")
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("response: \(response)")
                if (response.statusCode != 200) {
                    let resp = ["success": false]
                    return completionHandler(resp)
                }
            }
            if let error = error {
                print(error.localizedDescription)
                let resp = ["success": false]
                return completionHandler(resp)
            } else if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string: \(dataString)")
                print("Data: \(data)")
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if var responseJSON = responseJSON as? [String:Any] {
                    responseJSON["success"] = true
                    return completionHandler(responseJSON)
                }
                
//                let resp = ["success": true, "response": dataString] as [String : Any]
                let resp = ["success": false]
                
                return completionHandler(resp)
            }
            
        }
        task.resume()
    }
}
