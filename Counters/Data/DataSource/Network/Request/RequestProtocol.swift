//
//  RequestProtocol.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Alamofire

internal protocol RequestObject {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var encoding: JSONEncoding { get }
    var parameters: Parameters { get set }
}
