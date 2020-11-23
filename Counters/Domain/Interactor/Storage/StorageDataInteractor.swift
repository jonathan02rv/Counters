//
//  StorageDataInteractor.swift
//  Counters
//
//  Created by Jhonatahan on 11/22/20.
//

import Foundation

public protocol StorageDataInteractorProtocol{
    func saveListCounters(counters: [CounterModel])
    func updateStorageCounter(counter: CounterModel)
    func getAllStorageCounters()->[CounterModel]
    func deleteCounter(forId counterId: String) -> Bool
    func deleteAllCounters()
}

public class StorageDataInteractor: Interactor, StorageDataInteractorProtocol{
    public func saveListCounters(counters: [CounterModel]) {
        (self.repository as! StorageDataRepositoryProtocol).saveListCounters(counters: counters)
    }
    
    public func updateStorageCounter(counter: CounterModel) {
        (self.repository as! StorageDataRepositoryProtocol).updateStorageCounter(counter: counter)
    }
    
    public func getAllStorageCounters() -> [CounterModel] {
        (self.repository as! StorageDataRepositoryProtocol).getAllStorageCounters()
    }
    
    public func deleteCounter(forId counterId: String) -> Bool {
        (self.repository as! StorageDataRepositoryProtocol).deleteCounter(forId: counterId)
    }
    
    public func deleteAllCounters() {
        (self.repository as! StorageDataRepositoryProtocol).deleteAllCounters()
    }
    
    
}
