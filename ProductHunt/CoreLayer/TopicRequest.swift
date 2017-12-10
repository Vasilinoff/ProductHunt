//
//  Request.swift
//  ProductHunt
//
//  Created by Vasily on 09.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

class TopicRequest: Requestable {
    let apiKey = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    let URLString = "https://api.producthunt.com/v1/topics?search[trending]=true"
    
    var urlRequest: URLRequest? {
        let urlString: String = URLString
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            return request
        }
        
        return nil
    }
}
