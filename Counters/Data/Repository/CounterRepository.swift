//
//  CounterRepository.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

public class CounterRepository: CounterRepositoryProtocol{
    
    private let dataSource: ServiceDataSourceProtocol
    
    public init(){
        self.dataSource = ServiceDataSource()
    }
   
    
    public func getCountersAll(completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        self.dataSource.getCountersAll(request: AllCountersRequestObject()) { (result) in
            switch result{
            case .success(let data):
                completion(.success(CounterEntity.mapperCounterArray(dataArray: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func createCounter(counterTitle:String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        let params = ["title":"\(counterTitle)"] as [String : Any]
        self.dataSource.createCounter(request: CreateCounterRequestObject(parameters: params)) { (result) in
            switch result{
            case .success(let data):
                completion(.success(CounterEntity.mapperCounterArray(dataArray: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func deteleCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        let params = ["id":"\(counterId)"] as [String : Any]
        self.dataSource.deteleCounter(request: DeleteCounterRequestObject(parameters: params)) { (result) in
            switch result{
            case .success(let data):
                completion(.success(CounterEntity.mapperCounterArray(dataArray: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func incrementCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        let params = ["id":"\(counterId)"] as [String : Any]
        self.dataSource.incrementCounter(request: IncrementCounterRequestObject(parameters: params)) { (result) in
            switch result{
            case .success(let data):
                completion(.success(CounterEntity.mapperCounterArray(dataArray: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func decrementCounter(counterId:String, completion: @escaping (Result<[CounterModel], Error>) -> Void) {
        let params = ["id":"\(counterId)"] as [String : Any]
        self.dataSource.decrementCounter(request: DecrementCounterRequestObject(parameters: params)) { (result) in
            switch result{
            case .success(let data):
                completion(.success(CounterEntity.mapperCounterArray(dataArray: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
}
