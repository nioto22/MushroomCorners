//
//  UIColor+MesCoinsAChampi.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 11/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

extension UIColor {
    struct MesCoinsAChampi {
        struct ViewColor {
            static let BackgroundBlue = UIColor(red: 26/255, green: 120/255, blue: 181/255, alpha: 1)
            static let BackgroundRed = UIColor(red: 219/255, green: 49/255, blue: 70/255, alpha: 1)
        }
        struct TextColor {
            static let textColorBlue = UIColor.MesCoinsAChampi.ViewColor.BackgroundBlue
            static let textColorRed = UIColor.MesCoinsAChampi.ViewColor.BackgroundRed
            static let textColorBlack = UIColor.black
            static let textColorWhite = UIColor.white
            static let textColorGrey = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
        }
    }
    
}
