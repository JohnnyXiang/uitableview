//
//  NewCellWithImage.swift
//  uitableview
//
//  Created by Johnny Xiang on 7/30/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit
import Haneke

class NewCellWithImage: NewCellGeneral {
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var sourceImage: UIButton!
    @IBOutlet var sourceName: UIButton!

    
    @IBAction func sourceImageTapped(sender: AnyObject) {
        self.delegate?.sourceImageTapped(self.news)
    }
    
    override func newsDidSet() {
        self.newsTitle.text = news.getData("title")
        self.newsImage.hnk_setImageFromURL(NSURL(string:news.getData("image"))!)
        self.newsImage.clipsToBounds = true
        
        let cache = Shared.imageCache
        let URL = NSURL(string: news.data["source"]["icon"].string!)!
        cache.fetch(URL: URL).onSuccess { image in
            
            self.sourceImage.setBackgroundImage(image, forState: UIControlState.Normal)
            self.sourceName.setTitle(self.news.data["source"]["name"].string!, forState: UIControlState.Normal)
        }
        
        self.newsTitle.sizeToFit()

    }
}
