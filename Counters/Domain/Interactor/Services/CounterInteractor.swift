//
//  CounterInteractor.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

public protocol CounterInteractorProtocol{
    func getCountersAll(completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func createCounter(counterTitle:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func deteleCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func incrementCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
    func decrementCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void)
}

public class ArticlesInteractor:Interactor, CounterInteractorProtocol{

    public func getCountersAll(completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        return(self.repository as! CounterRepositoryProtocol).getCountersAll { (result) in
            switch result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func createCounter(counterTitle: String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        return(self.repository as! CounterRepositoryProtocol).createCounter(counterTitle: counterTitle) { (result) in
            switch result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func deteleCounter(counterId: String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        return(self.repository as! CounterRepositoryProtocol).deteleCounter(counterId: counterId) { (result) in
            switch result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func incrementCounter(counterId: String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        return(self.repository as! CounterRepositoryProtocol).incrementCounter(counterId: counterId) { (result) in
            switch result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func decrementCounter(counterId: String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        return(self.repository as! CounterRepositoryProtocol).decrementCounter(counterId: counterId) { (result) in
            switch result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
