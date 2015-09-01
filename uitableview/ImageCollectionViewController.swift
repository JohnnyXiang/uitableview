//
//  ImageCollectionViewController.swift
//  uitableview
//
//  Created by Johnny Xiang on 8/5/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let threshold:CGFloat = 100.0 // threshold from bottom of tableView
    var isLoadingPhotos = false
    var linkToFetch = "https://api.instagram.com/v1/tags/sunset/media/recent?access_token=203251101.1fb234f.451b23a663754f4f9c621f3b6fa989c4"
    var nextPageLink = ""
    
    @IBOutlet var collectionView: UICollectionView!
    
    let networkManager = NetworkManager()
    var photos = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loadPhotos { () -> Void in
            
        }
    
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    //load photos from instagram
    func loadPhotos(completion:() -> Void) {
        if  self.isLoadingPhotos == true {
            return
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.isLoadingPhotos = true
        
        if nextPageLink != "" {
            linkToFetch = nextPageLink
        }
        
        networkManager.manager.request(.GET, linkToFetch, encoding: .URL)
            
            .responseJSON { (request, response, responseJSON, error) in
                
                //println(response)
                self.isLoadingPhotos = false
                
                
                if(error != nil) {
                    
                    NSLog("Fetch  Collection Error: \(error)")
                } else if responseJSON == nil{
                    NSLog("Fetch News Collection Error: \(error)")
                }
                else {
                    
                    let jsonData = JSON(responseJSON!)
                    
                    for (id,photo) in jsonData["data"] {
                        //println(photo)
                        self.photos.append(photo)
                    }
                    
                    if let nextpage = jsonData["pagination"]["next_url"].string {
                        self.nextPageLink = nextpage

                    } else {
                        self.nextPageLink = ""
                    }
                    
                    self.collectionView.reloadData()
                    
                    
                    
                }
                
                
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionviewcell", forIndexPath: indexPath) as! PhotoCell
        
        
        let photo = self.photos[indexPath.row]
        
        cell.photoView.hnk_setImageFromURL(NSURL(string: photo["images"]["thumbnail"]["url"].string!)!)
        
        return cell
    }
    
    // deletage function to handle cell size
    func collectionView(collectionView: UICollectionView!,layout collectionViewLayout: UICollectionViewLayout!,sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        
        //auto width, show 3 items per row, with 5 cell spacing
        let cellWidth =  (self.view.frame.size.width-10)/3
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let photo = self.photos[indexPath.row]
        
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PhotoDetailViewController") as! PhotoDetailViewController
        
        destinationViewController.photo = photo
        destinationViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        
        
        if maximumOffset - contentOffset <= threshold {
            self.loadPhotos({ () -> Void in
                
            })
          
        }
        
        
    }


}
