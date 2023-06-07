//
//  RestaurantTableController.swift
//  The Foodie
//
//  Created by Shady Adel on 06/06/2023.
//

import UIKit

class RestaurantTableController: UITableViewController {
    
    // MARK: Local Data
    var restaurants:[Restaurant] = [ Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false), Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false), Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false), Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong" , image: "petiteoyster", isFavorite: false), Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false), Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong" , image: "posatelier", isFavorite: false), Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false), Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney" , image: "haigh", isFavorite: false), Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false), Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false), Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false), Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false), Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false), Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New Y ork", image: "fiveleaves", isFavorite: false), Restaurant(name: "Cafe Lore", type: "Latin American", location: "New Y ork", image: "cafelore", isFavorite: false), Restaurant(name: "Confessional", type: "Spanish", location: "New York" , image: "confessional", isFavorite: false), Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false), Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false), Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false), Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "Lond on", image: "cask", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurants.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: self.restaurants[indexPath.row].image)
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.heartImage.isHidden = self.restaurants[indexPath.row].isFavorite ? false : true
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ [self] (_,_,completionHandler) in
            restaurants.remove(at: indexPath.row)
            tableView.reloadData()
            completionHandler(true)
        }
        let shareAction = UIContextualAction(style: .normal, title: "Share") { [self] (_,_,completionHandler) in
            let defaultText = "Just checking in at "  + restaurants[indexPath.row].name
            
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(named: restaurants[indexPath.row].image) { activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil) }
            else { activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil) }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: nil){_,_,completionHandler in
            
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            
            cell.heartImage.isHidden = self.restaurants[indexPath.row].isFavorite
            
            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
            
            completionHandler(true)
        }
        
        // Configure swipe action
        favAction.backgroundColor = UIColor.systemYellow
        favAction.image = UIImage(systemName: self.restaurants[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.fill")
        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favAction])
        return swipeConfiguration
    }
}
