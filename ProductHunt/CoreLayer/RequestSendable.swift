//
//  RequestSendable.swift
//  ProductHunt
//
//  Created by Vasily on 10.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation


struct RequestConfig<T> {
    let request: Requestable
    let parser: Parser<T>
}

enum Result<T> {
    case Success(T)
    case Fail(String)
}



protocol RequestSendable {
    func send<T>(config: RequestConfig<T>, completionHandler: @escaping (Result<T>) -> Void)
}
