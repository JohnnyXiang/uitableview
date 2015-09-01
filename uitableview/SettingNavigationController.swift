//
//  SettingNavigationController.swift
//  uitableview
//
//  Created by Johnny Xiang on 8/6/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class SettingNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
            super.viewDidDisappear(animated)
        
        self.popToRootViewControllerAnimated(animated)
    }
}
