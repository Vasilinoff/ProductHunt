//
//  ProductParser.swift
//  ProductHunt
//
//  Created by Vasily on 10.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

class ProductParser: Parser<[Product]> {
    
    override func parse (data: Data) -> [Product]? {
        do {
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else {
                return nil
            }
            
            guard let product = json["posts"] as? [[String: AnyObject]] else {
                return nil
            }
            
            return product.flatMap{ Product.init(json: $0) }
            
        } catch {
            print("JSON serialization fail!")
        }
        
        return nil
    }
}
