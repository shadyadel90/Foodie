//
//  RestaurantTableController.swift
//  The Foodie
//
//  Created by Shady Adel on 06/06/2023.
//

import UIKit
import CoreData
import UserNotifications

class RestaurantTableController: UITableViewController {
    
    var spinner = UIActivityIndicatorView()
    var fetchResultController: NSFetchedResultsController<Restaurant>!
    lazy var dataSource = configureDataSource()
    
    @IBOutlet var emptyRestaurantView: UIView!
    var searchController: UISearchController!
    
    
    // MARK: Local Data
    var restaurants:[Restaurant] = [
        //        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: false),
        //        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phone: "348-233423", description: "A little gem hidden at the corner of the street is nothing but fantastic! This place is warm and cozy. We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of coffee drinks and specialties including lattes, cappuccinos, teas, and more. We serve breakfast, lunch, and dinner in an airy open setting. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "homei", isFavorite: false),
        //        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "354-243523", description: "Take a moment to stop and smell tealeaves! We are about the community, our environment, and all things created by the warmth of our hands. We open at 11 AM, and close at 7 PM. At teakha, we sell only the best single-origin teas sourced by our sister company Plantation directly from small tea plantations. The teas are then either cooked to perfection with milk in a pot or brewed.", image: "teakha", isFavorite: false),
        //        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "453-333423", description: "A great cafe in Austrian style. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. We also serve breakfast and light lunch. Come over to enjoy the elegant ambience and quality coffee.", image: "cafeloisl", isFavorite: false),
        //        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "983-284334", description: "An upscale dining venue, features premium and seasonal imported oysters, and delicate yet creative modern European cuisines. Its oyster bar displays a full array of freshest oysters imported from all over the world including France, Australia, USA and Japan.", image: "petiteoyster", isFavorite: false),
        //        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phone: "232-434222", description: "A great local cafe for breakfast and lunch! Located in a quiet area in Sheung Wan, we offer pork chop buns, HK french toast, and many more. We open from 7 AM to 4:30 PM.", image: "forkee", isFavorite: false),
        //        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phone: "234-834322", description: "A boutique bakery focusing on artisan breads and pastries paired with inspiration from Japan and Scandinavia. We are crazy about bread and excited to share our artisan bakes with you. We open at 10 every morning, and close at 7 PM.", image: "posatelier", isFavorite: false),
        //        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phone: "982-434343", description: "We make everything by hand with the best possible ingredients, from organic sourdoughs to pastries and cakes. A combination of great produce, good strong coffee, artisanal skill and hard work creates the honest, soulful, delectable bites that have made Bourke Street Bakery famous. Visit us at one of our many Sydney locations!", image: "bourkestreetbakery", isFavorite: false),
        //        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phone: "734-232323", description: "Haigh's Chocolates is Australia's oldest family owned chocolate maker. We have been making chocolate in Adelaide, South Australia since 1915 and we are committed to the art of premium chocolate making from the cocoa bean. Our chocolates are always presented to perfection in our own retail stores. Visit any one of them and you'll find chocolate tasting, gift wrapping and personalised attention are all part of the service.", image: "haigh", isFavorite: false),
        //        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phone: "872-734343", description: "We offer an assortment of on-site baked goods and sandwiches. This place has always been a favourite among office workers. We open at 7 every morning including Sunday, and close at 4 PM. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "palomino", isFavorite: false),
        //        Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", phone: "343-233221", description: "The absolute best seafood place in town. The atmosphere here creates a very homey feeling. We open at 5 PM, and close at 10:30 PM.", image: "upstate", isFavorite: false),
        //        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phone: "985-723623", description: "A young crowd populates this pork-focused American eatery in an older Williamsburg neighborhood. We open at 6PM, and close at 11 PM. If you enjoy a shared small plates dinner experience, come over and have a try.", image: "traif", isFavorite: false),
        //        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phone: "455-232345", description: "Classic Italian deli & butcher draws patrons with meat-filled submarine sandwiches. We use the freshest meats and veggies to create the perfect panini for you. We look forward to seeing you!", image: "graham", isFavorite: false),
        //        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phone: "434-232322", description: "Small shop, some seating, definitely something different! We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of waffles with choices of sweet & savory fillings. If you are gluten free and craving waffles, this is the place to go.", image: "waffleandwolf", isFavorite: false),
        //        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", phone: "343-234553", description: " Great food, cocktails, ambiance, service. Nothing beats having a warm dinner and a whiskey. We open at 8 every morning, and close at 1 AM. The ricotta pancakes are something you must try.", image: "fiveleaves", isFavorite: false),
        //        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phone: "342-455433", description: "Good place, great environment and amazing food! We open at 10 every morning except Sunday, and close at 9 PM. Give us a visit! Enjoy mushroom raviolis, pumpkin raviolis, meat raviolis with sausage and peppers, pork cutlets, eggplant parmesan, and salad.", image: "cafelore", isFavorite: false),
        //        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phone: "643-332323", description: "Most delicious cocktail you would ever try! Our menu includes a wide range of high quality internationally inspired dishes, vegetarian options, and local cuisine. We open at 10 AM, and close at 10 PM. We welcome you into our place to enjoy a meal with your friends.", image: "confessional", isFavorite: false),
        //        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phone: "542-343434", description: "a collection of authentic Spanish Tapas bars in Central London! We have an open kitchen, a beautiful marble-topped bar where guests can sit and watch the chefs at work and stylish red leather stools. Lunch starts at 1 PM. Dinners starts 5:30 PM.", image: "barrafina", isFavorite: false),
        //        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phone: "722-232323", description: "Very good basque food, creative dishes with terrific flavors! Donostia is a high end tapas restaurant with a friendly relaxed ambiance. Come over to enjoy awesome tapas!", image: "donostia", isFavorite: false),
        //        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phone: "343-988834", description: "Specialise in great pub food. Established in 1872, we have local and world lagers, craft beer and a selection of wine and spirits for people to enjoy. Don't forget to try our range of Young's Ales and Fish and Chips.", image: "royaloak", isFavorite: false),
        //        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phone: "432-344050", description: "With kitchen serving gourmet burgers. We offer food every day of the week, Monday through to Sunday. Join us every Sunday from 4:30 – 7:30pm for live acoustic music!", image: "cask", isFavorite: false)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil )
            
        }
    }
    
   @objc override func viewDidLoad() {
        super.viewDidLoad()
        
       prepareNotification()
       
        tableView.dataSource = dataSource
        
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true
        
        
        //MARK: Navigation bar Customizing
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        if let appearance = navigationController?.navigationBar.standardAppearance
        {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0){
                appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0), .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
        }
        
        searchController = UISearchController(searchResultsController: nil)
//        self.navigationItem.searchController = searchController
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = String(localized:"Search restaurants...")
        searchController.searchBar.backgroundImage = UIImage()
        fetchRestaurantData()
        
        
        spinner.style = .large
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        // Define layout constraints for the spinner
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        // Activate the spinner
        spinner.startAnimating()
        
        // Pull To Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.white
        refreshControl?.tintColor = UIColor.gray
        refreshControl?.addTarget(self, action: #selector(viewDidLoad), for: UIControl.Event.valueChanged)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
            spinner.stopAnimating()
            if let refreshControl = self.refreshControl {
                if refreshControl.isRefreshing { refreshControl.endRefreshing() } }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurants.count
    }
    
    
    
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        
        let cellIdentifier = "datacell"
        
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                
                cell.nameLabel.text = restaurant.name
                cell.locationLabel.text = restaurant.location
                cell.typeLabel.text = restaurant.type
                cell.thumbnailImageView.image = UIImage(data: restaurant.image)
                cell.heartImage.isHidden = restaurant.isFavorite ? false : true
                
                return cell
            }
        )
        print(dataSource)
        return dataSource
    }
    
    func fetchRestaurantData(searchText: String = "") {
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        }

        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self

            do {
                try fetchResultController.performFetch()
                updateSnapshot(animatingChange: searchText.isEmpty ? false : true)
            } catch {
                print(error)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if searchController.isActive { return UISwipeActionsConfiguration() }
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: String(localized: "Delete")){ [self] (_,_,completionHandler) in
            //            restaurants.remove(at: indexPath.row)
            //            tableView.reloadData()
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                context.delete(restaurant)
                appDelegate.saveContext()
                self.updateSnapshot(animatingChange: true)
            }
            completionHandler(true)
        }
        let shareAction = UIContextualAction(style: .normal, title: String(localized:"Share")) { [self] (_,_,completionHandler) in
            let defaultText = "Just checking in at "  + restaurants[indexPath.row].name
            
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(data: restaurants[indexPath.row].image) { activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil) }
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
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = self.restaurants[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchRestaurantData() {
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                updateSnapshot()
                
            } catch {
                print(error)
                
            } } }
    
    func updateSnapshot(animatingChange: Bool = false) {
        
        if let fetchedObjects = fetchResultController.fetchedObjects
        {
            restaurants = fetchedObjects
            
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        let configuration = UIContextMenuConfiguration(identifier: indexPath.row as NSCopying, previewProvider: {
            
            guard let restaurantDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else {
                return nil
            }
            
            restaurantDetailViewController.restaurant = restaurant
            
            return restaurantDetailViewController
            
        }) { actions in
            
            let favoriteAction = UIAction(title: String(localized:"Save as favorite"), image: UIImage(systemName: "heart")) { action in
                
                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                self.restaurants[indexPath.row].isFavorite.toggle()
                cell.heartImage.isHidden = !self.restaurants[indexPath.row].isFavorite
            }
            
            let shareAction = UIAction(title: String(localized:"Share"), image: UIImage(systemName: "square.and.arrow.up")) { action in
                
                let defaultText = NSLocalizedString("Just checking in at ", comment: "Just checking in at") + self.restaurants[indexPath.row].name
                
                let activityController: UIActivityViewController
                
                if let imageToShare = UIImage(data: restaurant.image as Data) {
                    activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                } else  {
                    activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                }
                
                self.present(activityController, animated: true, completion: nil)
            }
            
            let deleteAction = UIAction(title: String(localized:"Delete"), image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                
                // Delete the row from the data store
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    let context = appDelegate.persistentContainer.viewContext
                    let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                    context.delete(restaurantToDelete)
                    
                    appDelegate.saveContext()
                }
            }

            // Create and return a UIMenu with the share action
            return UIMenu(title: "", children: [favoriteAction, shareAction, deleteAction])
        }
        
        return configuration
    }
    
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        
        guard let selectedRow = configuration.identifier as? Int else {
            print("Failed to retrieve the row number")
            return
        }
        
        guard let restaurantDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else {
            
            return
        }
        
        restaurantDetailViewController.restaurant = self.restaurants[selectedRow]
        
        animator.preferredCommitStyle = .pop
        animator.addCompletion {
            self.show(restaurantDetailViewController, sender: self)
        }
    }
    
    // MARK: - User Notification
    
    func prepareNotification() {
        // Make sure the restaurant array is not empty
        if restaurants.count <= 0 {
            return
        }

        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]

        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location). Would you like to give it a try?"
        content.sound = UNNotificationSound.default

        // Add image to the notification
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")

        if let image = UIImage(data: suggestedRestaurant.image as Data) {

            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
                content.attachments = [restaurantImage]
            }
        }
        
        let categoryIdentifer = "foodpin.restaurantaction"
        let makeReservationAction = UNNotificationAction(identifier: "foodpin.makeReservation", title: "Reserve a table", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = categoryIdentifer
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "foodpin.restaurantSuggestion", content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    
}
extension RestaurantTableController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
        
    }
}
extension RestaurantTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text
        else {
            return
        }
        fetchRestaurantData(searchText: searchText)
        
    } }
