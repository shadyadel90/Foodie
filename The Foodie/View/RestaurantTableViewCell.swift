//
//  RestaurantTableViewCell.swift
//  The Foodie
//
//  Created by Shady Adel on 06/06/2023.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!{
        didSet {
            thumbnailImageView.layer.cornerRadius = 20
            thumbnailImageView.clipsToBounds = true
            
        }
    }
    @IBOutlet var heartImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
