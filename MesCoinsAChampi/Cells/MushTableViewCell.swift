//
//  MushTableViewCell.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 12/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

class MushTableViewCell: UITableViewCell {

    // FOR DESIGN
    
    @IBOutlet weak var mushSmallImageView: UIImageView!
    @IBOutlet weak var musBackgroundImageView: UIImageView!
    @IBOutlet weak var mushTitleLabel: UILabel!
    @IBOutlet weak var mushAdressLabel: UILabel!
    @IBOutlet weak var mushDateLabel: UILabel!
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
