//
//  CounterModel.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

public class CounterModel{
    public let id: String
    public let title: String
    public var count: Int
    
    public init(id: String, title: String, count: Int){
        self.id = id
        self.title = title
        self.count = count
    }
}
