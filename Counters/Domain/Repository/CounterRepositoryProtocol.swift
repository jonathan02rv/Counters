//
//  CounterRepositoryProtocol.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

public protocol RepositoryProtocol{
    
}

public protocol CounterRepositoryProtocol: RepositoryProtocol{
    func getCountersAll(completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func createCounter(counterTitle:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func deteleCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func incrementCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func decrementCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
}
