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
    let description: String
    let thumbnailURL: URL
    var preloadedThumbnail: UIImage?
    let upvotes: Int
    let screenshotURL: URL
    let link: URL
    
    init?(json: [String: AnyObject] ) {
        //print(json)
        guard let name = json["name"] as? String, let description = json["tagline"] as? String, let upvotes = json["votes_count"] as? Int, let thumbnail = json["thumbnail"] as? [String: AnyObject], let thumbnailURLString = thumbnail["image_url"] as? String, let thumbnailURL = URL(string: thumbnailURLString), let screenshot = json["screenshot_url"] as? [String: AnyObject], let screenshotURLString = screenshot["300px"] as? String, let screenshotURL = URL(string: screenshotURLString), let linkString = json["redirect_url"] as? String, let link = URL(string: linkString)
             else {
                return nil
        }
//        guard let imageData = try? Data(contentsOf: thumbnailURL as URL) else {
//            return nil
//        }

        self.name = name
        self.thumbnailURL = thumbnailURL
        self.description = description
        self.upvotes = upvotes
        self.screenshotURL = screenshotURL
        self.link = link
        //self.thumbnailURL = thumbnailURL
        //self.upvotes = upvotes
    }
}
