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
    static func getPickups(completion: @escaping ([[String:Any]]?) -> Void) {
       
        
        guard let url = URL(string: ProcessInfo.processInfo.environment["DATABASE_URL"]! + "/food_request/get-all") else { fatalError() }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string: \(dataString)")
            }
            
            if let error = error {
            print(error.localizedDescription)
            } else if let data = data {
            let dataDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            let foodRequests = dataDict["food_requests"] as! [[String: Any]]
            return completion(foodRequests)
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
    
    static func postFoodRequest(name: String, address: String, phoneNumber: String, pickupTime: String, foodType: String, quantity: String, dateCreated: String, points: Int) {
        
    
    
    
    }
    
    
    
}


