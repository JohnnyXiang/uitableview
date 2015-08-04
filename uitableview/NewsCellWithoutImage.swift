//
//  NewsCellWithoutImage.swift
//  uitableview
//
//  Created by Johnny Xiang on 7/31/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit
import Haneke
class NewsCellWithoutImage: NewCellGeneral {
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var newsSummary: UILabel!
    @IBOutlet var sourceImage: UIButton!
    @IBOutlet var sourceName: UIButton!

    
    
    override func newsDidSet() {
        self.newsTitle.text = news.getData("title")
        self.newsSummary.text =  news.getData("summary")
        
        let cache = Shared.imageCache
        let URL = NSURL(string: news.data["source"]["icon"].string!)!
        cache.fetch(URL: URL).onSuccess { image in
            self.sourceImage.setBackgroundImage(image, forState: UIControlState.Normal)
            self.sourceName.setTitle(self.news.data["source"]["name"].string!, forState: UIControlState.Normal)
        }
        
        self.newsTitle.sizeToFit()
        self.newsSummary.sizeToFit()
        
    }

}
