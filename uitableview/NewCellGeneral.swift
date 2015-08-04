//
//  NewCellGeneral.swift
//  uitableview
//
//  Created by Johnny Xiang on 7/31/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit
import Haneke
protocol NewCellDelegate{
    func sourceImageTapped(news:Post)->Void
}

class NewCellGeneral: UITableViewCell {
    
    var delegate:NewCellDelegate?
    var news:Post! {
        didSet{
            self.newsDidSet()
        }
    }
    
    func newsDidSet() {
        
    }
}
