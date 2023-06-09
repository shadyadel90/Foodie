//
//  AboutTableViewController.swift
//  The Foodie
//
//  Created by Shady Adel on 26/06/2023.
//

import UIKit
import SafariServices
class AboutTableViewController: UITableViewController {

    enum Section {
        case feedback
        case followus
        
    }
    
    struct LinkItem: Hashable {
        var text: String
        var link: String
        var image: String
        
        init(text: String, link: String, image: String) {
            self.text = text
            self.link = link
            self.image = image
        }
    }
    
    var sectionContent = [
        [
            LinkItem(text: String(localized:"Rate us on App Store"), link: "https://www.apple.com/ios/app-store/", image: "store"), LinkItem(text: String(localized:"Tell us your feedback"), link: "https://www.linkedin.com/in/shadyadel9/", image: "chat")
        ],
        [
            LinkItem(text: String(localized:"Twitter"), link: "https://twitter.com", image: "twitter"), LinkItem(text: String(localized:"Facebook"), link: "https://facebook.com", image: "facebook"), LinkItem(text: String(localized: "Instagram"), link: "https://www.instagram.com", image: "instagram")
        ]
    ]

    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use large title for the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        // Customize the navigation bar appearance
        if let appearance = navigationController?.navigationBar.standardAppearance { appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
               
                appearance.largeTitleTextAttributes = [.font: customFont]
                
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
      
        tableView.dataSource = dataSource
        updateSnapshot()
    }

    // MARK: - Table view data source

    func configureDataSource() -> UITableViewDiffableDataSource<Section, LinkItem> {
        let cellIdentifier = "aboutcell"
        let dataSource = UITableViewDiffableDataSource<Section, LinkItem>(tableView: tableView) { (tableView, indexPath, linkItem) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = linkItem.text
            cell.imageView?.image = UIImage(named: linkItem.image)
            return cell
            
        }
        return dataSource
        
    }
    
    func updateSnapshot() { // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, LinkItem>()
        snapshot.appendSections([.feedback, .followus])
        snapshot.appendItems(sectionContent[0], toSection: .feedback)
        snapshot.appendItems(sectionContent[1], toSection: .followus)
        dataSource.apply(snapshot, animatingDifferences: false) }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath : IndexPath) {
        // Get the selected link item
//        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
//        if let url = URL(string: linkItem.link) {
//            UIApplication.shared.open(url)
//        }
        
        switch indexPath.section {
            case 0: performSegue(withIdentifier: "showWebView", sender: self)
            case 1: openWithSafariViewController(indexPath: indexPath)
            default: break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView" {
            if let destinationController = segue.destination as? WebViewController,
               let indexPath = tableView.indexPathForSelectedRow,
               let linkItem = self.dataSource.itemIdentifier(for: indexPath) { destinationController.targetURL = linkItem.link
                
            }
        }
    }
    
    func openWithSafariViewController(indexPath: IndexPath) {
        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        
        if let url = URL(string: linkItem.link) {
            DispatchQueue.main.async {
                let safariController = SFSafariViewController(url: url)
                self.present(safariController, animated: true, completion: nil)
            }
           
        }
    }
}
