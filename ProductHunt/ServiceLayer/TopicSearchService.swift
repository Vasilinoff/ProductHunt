//
//  TopicSearchService.swift
//  ProductHunt
//
//  Created by Vasily on 10.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

class TopicSearchService {
    
    let requestSender: RequestSendable
    
    init(requestSender: RequestSender) {
        self.requestSender = requestSender
    }
    
    func topicSearch(completionHandler: @escaping ([Topic]?, String?) -> Void) {
        
        let requestConfig: RequestConfig<[Topic]> = RequestsFactory.TopicReq.topicConfig()
        requestSender.send(config: requestConfig) { (result: Result<[Topic]>) in
            switch result {
            case .Success(let apps):
                completionHandler(apps, nil)
            case .Fail(let error):
                completionHandler(nil, error)
            }
        }
    }
}
