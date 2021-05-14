//
//  PickupsViewController.swift
//  Donate Food
//
//  Created by Jahnae Reese 2 on 4/21/21.
//  Copyright © 2021 CodePath. All rights reserved.
//

import UIKit

class PickupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    

    @IBOutlet weak var tableView: UITableView!
    

    
    var foodRequestsArray: [[String: Any?]] = []
    let foodRefresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        //self.tableView.reloadData()
        
        getAPIData()
        
        tableView.refreshControl = foodRefresh
    }
    
    @objc func getAPIData() {
        API.getPickups() { (foodRequests) in
            guard let foodRequests = foodRequests else {
                return
            }
            
            self.foodRequestsArray = foodRequests
            self.tableView.reloadData()
            
            self.foodRefresh.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodRequestsArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let foodRequest = foodRequestsArray[indexPath.row]
        
        
        let restaurant = foodRequest["restaurant"] as! [String: Any]
        
        cell.nameLabel.text = restaurant["name"] as? String ?? ""
        cell.timeLabel.text = foodRequest["time"] as? String ?? ""
        cell.addressLabel.text = restaurant["address"] as? String ?? ""
        cell.foodLabel.text = foodRequest["food_type"] as? String ?? ""
        cell.quantityLabel.text = foodRequest["food_quantity"] as? String ?? ""
        
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let tableindex = foodRequestsArray[indexPath.row]
            let acceptFoodRequestController = segue.destination as? acceptRequestViewController
           
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

