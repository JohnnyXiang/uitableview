//
//  Post.swift
//  uitableview
//
//  Created by Johnny Xiang on 8/3/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit


class Post{
    var data:JSON!;
    let networkManager = NetworkManager()
    
    init (data: JSON?){
        self.data = data;
        
    }
    
    func encodeUrlString(urlString:String) ->String {
        var filtered = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        return filtered
        
    }
    
    func title() -> String {
        return self.getData("title")
    }
    
    func summary() ->String {
        return self.getData("summary")
    }
    
    
    func getData(key: String) ->String {
        if let string =  self.data[key].string {
            return string
        }
         return ""
    }
    
    
    func hasImage() -> Bool {
        let imageUrl = self.getData("image")
        
        //println(imageUrl)
        if imageUrl != "" {
            
            if let URL = NSURL(string: imageUrl) {
                return true
            }

        }
        
        return false
    }
    
}


class PostCollection {
    var offset = 0
    var size = 20
    var page_count = 1
    var total_items = 0;
    var first_page_link = "http://52.24.143.251/post?topic=Headline"
    var linkToFetch = "";
    var next_link = "";
    var initialLoad = true
    var fetched = [String]()
    let networkManager = NetworkManager()
    
    
    func fetchData(completion:([Post],error: NSError? ) -> Void){
  
        if initialLoad == true {
           
            next_link = first_page_link
            initialLoad = false
            
        }
        
        if next_link != "" {
            linkToFetch = next_link
        } else {
            linkToFetch = first_page_link
        }
        
        println(linkToFetch)
        networkManager.manager.request(.GET, linkToFetch, encoding: .JSON)
            
            .responseJSON { (request, response, responseJSON, error) in
                //println(responseJSON)
                
                if(error != nil) {
                    completion([],error:error)
                    NSLog("Fetch News Collection Error: \(error)")
                } else if responseJSON == nil{
                    NSLog("Fetch News Collection Error: \(error)")
                }
                else {
                    
                    let jsonData = JSON(responseJSON!)
                    
                   
                    
                    if let next = jsonData["_links"]["next"]["href"].string{
                        self.next_link = jsonData["_links"]["next"]["href"].string!
                    }else{
                        self.next_link = ""
                    }
                    
                    self.page_count = jsonData["page_count"].int!
                    self.total_items = jsonData["total_items"].int!
                    
                    var results = [Post]()
                    
                    for (key: String, postData: JSON) in jsonData["_embedded"]["post"] {
                        //println(poseData)
                        let post = Post(data: postData)
                        results.append(post)
                    }
                    
                    completion(results,error:nil)
                    
                }
        }
        
    }
}
