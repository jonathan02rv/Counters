//
//  CounterEntity.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

struct CounterEntity: Codable {
    var id:String
    var title:String?
    var count: Int
}

extension CounterEntity{
    
    static func mapperCounter(data:CounterEntity)->CounterModel{
        return CounterModel(id: data.id, title: data.title ?? "", count: data.count)
    }
    
    static func mapperCounterArray(dataArray:[CounterEntity])-> [CounterModel]{
        return dataArray.map { CounterModel(id: $0.id, title: $0.title ?? "", count: $0.count)
        }
    }
}
