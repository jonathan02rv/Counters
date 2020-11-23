//
//  StorageDataSourceProtocol.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation

internal protocol StorageDataSourceProtocol{
    func createNewCounter(counter: CounterModel)
    func updateStorageCounter(counter: CounterModel)
    func getAllStorageCounters()->[CounterModel]
    func deleteCounter(forId counterId: String) -> Bool
    func deleteAllCounters()
}
