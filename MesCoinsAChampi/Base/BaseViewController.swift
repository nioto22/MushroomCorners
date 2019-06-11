//
//  BaseViewController.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 11/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var tabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarSeparators()
    }
    

    func setupTabBarSeparators() {
        let itemWidth = floor(self.tabBar.frame.size.width / CGFloat(self.tabBar.items!.count))
        
        // this is the separator width.  0.5px matches the line at the top of the tab bar
        let separatorWidth: CGFloat = 0.5
        
        // iterate through the items in the Tab Bar, except the last one
        for i in 0...(self.tabBar.items!.count - 1) {
            // make a new separator at the end of each tab bar item
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1) - CGFloat(separatorWidth / 2), y: 0, width: CGFloat(separatorWidth), height: self.tabBar.frame.size.height))
            
            // set the color to light gray (default line color for tab bar)
            separator.backgroundColor = UIColor.lightGray
            
            self.tabBar.addSubview(separator)
        }
    }

}
