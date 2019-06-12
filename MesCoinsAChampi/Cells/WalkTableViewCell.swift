//
//  WalkTableViewCell.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 12/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

class WalkTableViewCell: UITableViewCell {

    
    // FOR DESIGN
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var walkTitleLabel: UILabel!
    @IBOutlet weak var numberOfMushLabel: UILabel!
    @IBOutlet weak var walkAdressLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
