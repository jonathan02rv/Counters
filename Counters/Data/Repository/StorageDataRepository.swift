//
//  StorageDataRepository.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation

public class StorageDataRepository: StorageDataRepositoryProtocol{
    
    private let dataSource: StorageDataSourceProtocol
    public init(){
        self.dataSource = StorageDataSource()
    }
    
    
    public func createNewCounter(counter: CounterModel) {
        dataSource.createNewCounter(counter: counter)
    }
    
    public func updateStorageCounter(counter: CounterModel) {
        dataSource.updateStorageCounter(counter: counter)
    }
    
    public func getAllStorageCounters() -> [CounterModel] {
        dataSource.getAllStorageCounters()
    }
    
    public func deleteCounter(forId counterId: String) -> Bool {
        dataSource.deleteCounter(forId: counterId)
    }
    
    public func deleteAllCounters() {
        dataSource.deleteAllCounters()
    }
    
    
    
    
   
    
}
