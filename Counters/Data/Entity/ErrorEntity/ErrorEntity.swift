//
//  ErrorEntity.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

struct ErrorEntity: Error {
    var type: ServiceErrorType
    var reason: String
}

extension ErrorEntity {
    static func get(_ error: Error) -> ErrorModel {
        guard let serviceError = error as? ErrorEntity else {
            return ErrorModel(type: .unknownError, description: NSLocalizedString("defaultError", comment: "defaultError"))
        }
        return ErrorModel(type: ResponseType(rawValue: serviceError.type.rawValue), description: serviceError.reason)
    }
}
