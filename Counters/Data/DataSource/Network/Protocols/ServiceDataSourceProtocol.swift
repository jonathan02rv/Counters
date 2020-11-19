//
//  ServiceDataSourceProtocol.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

internal protocol ServiceDataSourceProtocol{
    
    func getCounters(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity],Error>)->Void)
    
    func createCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity],Error>)->Void)
    
    func deteleCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity],Error>)->Void)
    
    func incrementCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity],Error>)->Void)
    
    func decrementCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity],Error>)->Void)
}
