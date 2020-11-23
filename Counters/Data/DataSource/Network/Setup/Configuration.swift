//
//  Configuration.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

public protocol Configuration {
   static var serverBaseUrl: String { get }
}

struct AppConfig: Configuration {
    static let serverBaseUrl = "http://localhost:3000/api/v1"
}
