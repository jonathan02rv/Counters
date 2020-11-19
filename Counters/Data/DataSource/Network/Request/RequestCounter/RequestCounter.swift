//
//  RequestCounter.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation
import Alamofire

internal struct AllCountersRequestObject: RequestObject{
    var path: String = "/counters"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders
    let encoding: JSONEncoding = .default
    var parameters: Parameters = [:]
    
    init() {
        headers = headerDefault
    }
}

internal struct CreateCounterRequestObject: RequestObject{
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

internal struct DeleteCounterRequestObject: RequestObject{
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

internal struct IncrementCounterRequestObject: RequestObject{
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

internal struct DecrementCounterRequestObject: RequestObject{
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
