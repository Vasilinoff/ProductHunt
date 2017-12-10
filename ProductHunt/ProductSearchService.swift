//
//  ProductSearchService.swift
//  ProductHunt
//
//  Created by Vasily on 10.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

class ProductSearchService {
    
    let requestSender: RequestSendable
    
    init(requestSender: RequestSender) {
        self.requestSender = requestSender
    }
    
    func productSearch(id: Int ,completionHandler: @escaping ([Product]?, String?) -> Void) {
        
        let requestConfig: RequestConfig<[Product]> = RequestsFactory.ProductReq.productConfig(id: id)
        requestSender.send(config: requestConfig) { (result: Result<[Product]>) in
            switch result {
            case .Success(let apps):
                completionHandler(apps, nil)
            case .Fail(let error):
                completionHandler(nil, error)
            }
        }
    }
}
