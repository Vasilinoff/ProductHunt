//
//  Requestable.swift
//  ProductHunt
//
//  Created by Vasily on 09.12.2017.
//  Copyright © 2017 Vasily. All rights reserved.
//

import Foundation

protocol Requestable {
    var urlRequest: URLRequest? { get }
}
