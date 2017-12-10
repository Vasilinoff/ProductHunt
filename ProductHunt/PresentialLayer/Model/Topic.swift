//
//  TopicModel.swift
//  ProductHunt
//
//  Created by Vasily on 10.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

class Topic {
    let name: String
    let id: Int
    
    init?(json: [String: AnyObject] ) {
        guard let name = json["name"] as? String,
        let id = json["id"] as? Int else {
                return nil
    }
        self.name = name
        self.id = id
    }
}
