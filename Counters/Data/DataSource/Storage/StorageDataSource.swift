//
//  StorageDataSource.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation

internal class StorageDataSource: StorageDataSourceProtocol{
    func createNewCounter(counter: CounterModel) {
        DatabaseManager.standard.addNewCounterToCoreData(counter)
    }
    
    func updateStorageCounter(counter: CounterModel) {
        DatabaseManager.standard.upDateCounter(counter)
    }
    
    func getAllStorageCounters() -> [CounterModel] {
        let counters = DatabaseManager.standard.getAllCounters()
        return counters.map { CounterModel(id: $0.id ?? "", title: $0.title ?? "", count: Int($0.count))}
    }
    
    func deleteCounter(forId counterId: String) -> Bool {
        return DatabaseManager.standard.deleteCounter(forId: counterId)
    }
    
    func deleteAllCounters() {
        DatabaseManager.standard.deleteAllCounters()
    }
    
    
    
}
