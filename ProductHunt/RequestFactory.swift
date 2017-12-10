//
//  RequestFactory.swift
//  ProductHunt
//
//  Created by Vasily on 09.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

struct RequestsFactory {
    struct TopicReq {
        static func topicConfig() -> RequestConfig<[Topic]> {
            let request = TopicRequest()
            return RequestConfig<[Topic]>(request: request, parser: TopicParser() )
        }
    }
    struct ProductReq {
        static func productConfig(id: Int) -> RequestConfig<[Product]> {
            let request = ProductRequest(id: id)
            return RequestConfig<[Product]>(request: request, parser: ProductParser() )
        }
    }
}
