//
//  NewsTableViewController.swift
//  uitableview
//
//  Created by Johnny Xiang on 7/30/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit
import Haneke
class NewsTableViewController: UITableViewController,NewCellDelegate {

    var news = [JSON]()
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
        networkManager.manager.request(.GET, "http://52.24.143.251/post?topic=Headline&pagelimit=3", parameters: nil, encoding: .JSON, headers: nil)
            .responseJSON { (request, response, responseJSON, error) in
                //println(responseJSON)
                
                if(error != nil) {
                    
                    NSLog("Fetch News Collection Error: \(error)")
                } else if responseJSON == nil{
                    NSLog("Fetch News Collection Error: \(error)")
                }
                else {
                     let jsonData = JSON(responseJSON!)
                    
                    self.news = jsonData["_embedded"]["post"].array!
                    
                    self.tableView.reloadData()
                }
        }

        
    }
    
    //delegate method
    override func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let news =  self.news[indexPath.row]
        var newsHasImage = false
        if let imageUrl = news["image"].string {
            if imageUrl != "" {
                if let URL = NSURL(string: news["image"].string!) {
                    newsHasImage = true
                }
            }
        }
        
        if newsHasImage == true {
            let cell = self.cellForNewsWithImage(news)
            return cell
        } else {
        
            
            let cell = self.cellForNewsWithoutImage(news)
            
             return cell
           
        
        }
        
        
       
        
        
    }
    
    func cellForNewsWithImage(news:JSON) -> NewCellWithImage {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellWithImage") as! NewCellWithImage
        cell.news = news
        cell.delegate = self
        return cell

    }
    
    func cellForNewsWithoutImage(news:JSON) ->NewsCellWithoutImage {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellWithoutImage") as! NewsCellWithoutImage
        
        
        cell.news = news
        cell.delegate = self
        
        return cell

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let news =  self.news[indexPath.row]
        
        let distViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewsDetailViewController") as! NewsDetailViewController
        
        distViewController.news_id = news["news_id"].string
        distViewController.news_url = news["original_link"].string
        
        self.navigationController?.pushViewController(distViewController, animated: true)
    }
    
    override func  tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
//        (cell as! NewCellWithImage).newsTitle.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sourceImageTapped(news:JSON)->Void {
        println(news)
    }
}
