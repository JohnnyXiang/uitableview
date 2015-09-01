//
//  PhotoDetailViewController.swift
//  uitableview
//
//  Created by Johnny Xiang on 8/5/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    var photo:JSON!
    
    @IBOutlet var captionTextView: UITextView!
    
    @IBOutlet var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.photoView.hnk_setImageFromURL(NSURL(string: photo["images"]["standard_resolution"]["url"].string!)!)
        
        self.captionTextView.text = photo["caption"]["text"].string!
        
        self.navigationController?.navigationBarHidden = false
    }
}
