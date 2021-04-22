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
    
    var restaurants: [String] = ["Golden Palace", "Amy's Cafe", "Joe's Grill", "Pete's Pizza", "Bob's Burger", "Olive Garden", "Royal Cuisine", "Chicken Express", "JollyBees", "Popeyes", "Mountain Mikes", "Tina's Tacos", "Dairy Queen", "Andrea's Food", "JJ's Fish & Chips", "Pancake House", "Napoli Pizzeria", "Ruth's Kitchen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        //self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let title = restaurants[indexPath.row]
        
        //cell.textLabel!.text = restaurants[indexPath.row]
        cell.nameLabel.text = title
        
        return cell;
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
