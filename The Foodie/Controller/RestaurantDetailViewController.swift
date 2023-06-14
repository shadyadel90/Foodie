//
//  RestaurantDetailViewController.swift
//  The Foodie
//
//  Created by Shady Adel on 08/06/2023.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    var restaurant: Restaurant = Restaurant()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    @IBOutlet var rateBut: UIButton!
    @IBOutlet var rateimage: UIImageView!
    @IBOutlet var heartButton: UIBarButtonItem!
    @IBAction func heartbarbutpressed(_ sender: UIBarButtonItem) {
        restaurant.isFavorite.toggle()
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) { appDelegate.saveContext()
        }
       
    }
    
 
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.backButtonTitle = ""
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(data: restaurant.image)
        
        heartbuttonn()
        ratemenu()
    }
    func ratemenu(){
        if restaurant.rating != nil {
            rateimage.image = UIImage(named: restaurant.rating!)
        }
        else {
            rateimage.image = UIImage()
        }
        let emojis = ["love","cool","happy","sad","angry"]
        var menu = [UIAction]()
        for i in emojis {
            menu.append(UIAction(title: i.capitalized, image: UIImage(named: i), handler: { [self] (_) in
                rateimage.image = UIImage(named: i)
                restaurant.rating =  i
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) { appDelegate.saveContext()
                }
            }))
        }
        var demoMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menu)
        }
        rateBut.menu = demoMenu
        rateBut.showsMenuAsPrimaryAction = true
    }
    func heartbuttonn(){
        let heartImage = restaurant.isFavorite ? "heart.fill" : "heart"
        let heartIconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        heartButton.image = UIImage(systemName: heartImage, withConfiguration: heartIconConfiguration)
        heartButton.tintColor = restaurant.isFavorite ? .systemYellow : .white
        
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showmap" {
                let destinationController = segue.destination as! MapViewController
                destinationController.restaurant = restaurant
            }
        }
    }


extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailViewDescriptionCell.self), for: indexPath) as! RestaurantDetailViewDescriptionCell
            cell.descriptionLabel.text = restaurant.summary
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String (describing: RestaurantDetailTwoColumnCell.self), for: indexPath) as! RestaurantDetailTwoColumnCell
            cell.column1TitleLabel.text = "Address"
            cell.column1TextLabel.setTitle(restaurant.location, for: .normal)
            cell.column2TitleLabel.text = "Phone"
            cell.column2TextLabel.text = restaurant.phone
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: (String(describing: RestaurantDetailMapCell.self)), for: indexPath) as! RestaurantDetailMapCell
            cell.configure(location: restaurant.location)
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
}
    


