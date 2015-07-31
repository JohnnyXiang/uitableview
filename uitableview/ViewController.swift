//
//  ViewController.swift
//  uitableview
//
//  Created by Johnny Xiang on 7/30/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textLabel: UILabel!
    
    var fromPage:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textLabel.text = fromPage
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

