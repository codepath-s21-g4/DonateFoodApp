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
}
