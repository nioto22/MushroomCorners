//
//  RoundedUIButtonView.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 11/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedUIButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor {
        didSet {
            self.layer.shadowColor = shadowColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        //self.layer.shadowColor = UIColor.MesCoinsAChampi.ViewColor.BackgroundBlue.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 0.95
        self.layer.masksToBounds = false
    }
}
