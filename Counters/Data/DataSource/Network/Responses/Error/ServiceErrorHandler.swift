//
//  ServiceErrorHandler.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

enum ServiceErrorType: String {
    case unknownError
    case networkError
    case custom
}

class ServiceErrorHandler {
    
    static func get(code:String?,description:String?) -> Error {
        guard let code = code, let description = description else {
            return ErrorEntity(type: .unknownError, reason: NSLocalizedString("defaultError", comment: "defaultError"))
        }
        return ErrorEntity(type: ServiceErrorType(rawValue: code) ?? ServiceErrorType.custom, reason: description)
    }
    
    static func getNetworkError()-> Error {
        return ErrorEntity(type: .networkError, reason: NSLocalizedString("networkConnectionError", comment: "networkConnectionError"))
    }
    
}
