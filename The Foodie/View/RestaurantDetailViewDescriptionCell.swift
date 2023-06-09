//
//  RestaurantDetailViewDescriptionCell.swift
//  The Foodie
//
//  Created by Shady Adel on 09/06/2023.
//

import UIKit

class RestaurantDetailViewDescriptionCell: UITableViewCell {

    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
