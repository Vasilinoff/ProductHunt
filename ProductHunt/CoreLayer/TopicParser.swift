//
//  Parser.swift
//  ProductHunt
//
//  Created by Vasily on 09.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

class Parser<T> {
    func parse(data: Data) -> T? { return nil }
}


class TopicParser: Parser<[Topic]> {
    
    override func parse (data: Data) -> [Topic]? {
        do {
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else {
                return nil
            }
            
            guard let topics = json["topics"] as? [[String: AnyObject]] else {
                return nil
            }
            
            return topics.flatMap{ Topic.init(json: $0)}
            
        } catch {
            print("JSON serialization fail!")
        }
        
        return nil
    }
}
