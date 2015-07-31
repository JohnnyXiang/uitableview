//
//  NetworkManager.swift
//  cnnews
//
//  Created by Johnny Xiang on 7/23/15.
//  Copyright (c) 2015 OU R&D. All rights reserved.
//

import Foundation

import Alamofire

class NetworkManager {
    
    var manager: Manager!
    
    init() {
        var headers = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        headers["Accept"] = "application/json"
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = headers
        
        manager = Alamofire.Manager.sharedInstance
        
        //        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        //        configuration.HTTPAdditionalHeaders = headers
        //
        //
        //        manager = Alamofire.Manager(configuration: configuration)
    }
}
