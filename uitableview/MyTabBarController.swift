//
//  MyTabBarController.swift
//  uitableview
//
//  Created by Johnny Xiang on 8/6/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        
        // tab bar color
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.barTintColor = UIColor.redColor()
        
        //set tab text attributes
        let attributes = [
            NSFontAttributeName: UIFont(name: "TrebuchetMS-Bold", size: 12)!,
            NSForegroundColorAttributeName: UIColor.greenColor()
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, forState:.Normal)
        
        
        //selected item text color
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        
        
        
        //self.tabBar.clipsToBounds = true
        
        var i=0
        for item in self.tabBar.items as! [UITabBarItem] {
            if i==0 {
                
            }
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
                item.selectedImage = image
            }
            
            item.setTitlePositionAdjustment(UIOffsetMake(0, -2.0))
            
        }
        
        
    }
}
