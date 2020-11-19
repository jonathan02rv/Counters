//
//  RequestCounter.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation
import Alamofire

internal struct CountersAllRequestObject: RequestObject{
    var path: String = "/counters"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders
    let encoding: JSONEncoding = .default
    var parameters: Parameters = [:]
    
    init() {
        headers = headerDefault
    }
}

internal struct CounterCreateRequestObject: RequestObject{
    var path: String = "/counter"
    let method: HTTPMethod = .post
    var headers: HTTPHeaders
    let encoding: JSONEncoding = .default
    var parameters: Parameters = [:]
    
    init(parameters: Parameters) {
        headers = headerDefault
        self.parameters = parameters
    }
}

internal struct CounterDeleteRequestObject: RequestObject{
    var path: String = "/counter"
    let method: HTTPMethod = .delete
    var headers: HTTPHeaders
    let encoding: JSONEncoding = .default
    var parameters: Parameters = [:]
    
    init(parameters: Parameters) {
        headers = headerDefault
        self.parameters = parameters
    }
}

internal struct CounterIncrementRequestObject: RequestObject{
    var path: String = "/counter/inc"
    let method: HTTPMethod = .post
    var headers: HTTPHeaders
    let encoding: JSONEncoding = .default
    var parameters: Parameters = [:]
    
    init(parameters: Parameters) {
        headers = headerDefault
        self.parameters = parameters
    }
}

internal struct CounterDecrementRequestObject: RequestObject{
    var path: String = "/counter/dec"
    let method: HTTPMethod = .post
    var headers: HTTPHeaders
    let encoding: JSONEncoding = .default
    var parameters: Parameters = [:]
    
    init(parameters: Parameters) {
        headers = headerDefault
        self.parameters = parameters
    }
}
