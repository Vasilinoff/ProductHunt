//
//  ProductModel.swift
//  ProductHunt
//
//  Created by Vasily on 09.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//
import UIKit
import Foundation

class Product {
    let name: String
    //let description: String
    //let thumbnailURL: URL
    //let upvotes: Int
    
    init?(json: [String: AnyObject] ) {
        //print(json)
        guard let name = json["name"] as? String, let description = json["tagline"] as? String, let upvotes = json["votes_count"] as? Int, let thumbnailURL = json["thumbnail"] as? [String: AnyObject]
             else {
                return nil
        }
//        guard let imageData = try? Data(contentsOf: thumbnailURL as URL) else {
//            return nil
//        }

        self.name = name
        //self.description = description
        //self.upvotes = upvotes
        //self.thumbnailURL = thumbnailURL
        //self.upvotes = upvotes
    }
}
