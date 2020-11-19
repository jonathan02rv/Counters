//
//  ErrorModel.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

// Internal errors
public enum ResponseType: String {
    case unknownError
    case networkError
    case custom
}

public class ErrorModel: Error{
    public var type: ResponseType?
    public var description: String?
    
    public init(type: ResponseType?, description: String?) {
        self.type = type
        self.description = description
    }
}
