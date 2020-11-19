//
//  ServiceDataSource.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//
import Foundation
import Alamofire

class ServiceDataSource: ServiceDataSourceProtocol{
    
    private var sessionManager: SessionManager?
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        self.sessionManager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager:  ServerTrustPolicyManager(policies: serverTrustPolicies))
    }
    
    func getCounters(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity], Error>) -> Void) {
        if Reachability.isConnectedToNetwork(){
            guard let requestRef = request as? CountersAllRequestObject else{return}
            let url = AppConfig.serverBaseUrl + requestRef.path
            
            sessionManager?.request(url, method: requestRef.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().debugLog().responseData(completionHandler: { (response) in
                
                let responseStr = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                debugPrint(responseStr ?? "")
                
                switch response.result{
                case .success(let data):
                    guard let dataResponse = try? JSONDecoder().decode([CounterEntity].self, from: data) else{
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: nil)))
                    }
                    completion(.success(dataResponse))
                    break
                case .failure(let error):
                    guard let data = response.data , let serviceError =  try? JSONDecoder().decode(BaseResponseEntity.self, from: data)  else {
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: error.localizedDescription)))
                    }
                    completion(.failure(ServiceErrorHandler.get(code: serviceError.code, description: serviceError.description)))
                }
            })
        }else{
            completion(.failure(ServiceErrorHandler.getNetworkError()))
        }
    }
    
    func createCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity], Error>) -> Void) {
        if Reachability.isConnectedToNetwork(){
            guard let requestRef = request as? CounterCreateRequestObject else{return}
            let url = AppConfig.serverBaseUrl + requestRef.path
            
            sessionManager?.request(url, method: requestRef.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().debugLog().responseData(completionHandler: { (response) in
                
                let responseStr = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                debugPrint(responseStr ?? "")
                
                switch response.result{
                case .success(let data):
                    guard let dataResponse = try? JSONDecoder().decode([CounterEntity].self, from: data) else{
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: nil)))
                    }
                    completion(.success(dataResponse))
                    break
                case .failure(let error):
                    guard let data = response.data , let serviceError =  try? JSONDecoder().decode(BaseResponseEntity.self, from: data)  else {
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: error.localizedDescription)))
                    }
                    completion(.failure(ServiceErrorHandler.get(code: serviceError.code, description: serviceError.description)))
                }
            })
        }else{
            completion(.failure(ServiceErrorHandler.getNetworkError()))
        }
    }
    
    func deteleCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity], Error>) -> Void) {
        if Reachability.isConnectedToNetwork(){
            guard let requestRef = request as? CounterDeleteRequestObject else{return}
            let url = AppConfig.serverBaseUrl + requestRef.path
            
            sessionManager?.request(url, method: requestRef.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().debugLog().responseData(completionHandler: { (response) in
                
                let responseStr = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                debugPrint(responseStr ?? "")
                
                switch response.result{
                case .success(let data):
                    guard let dataResponse = try? JSONDecoder().decode([CounterEntity].self, from: data) else{
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: nil)))
                    }
                    completion(.success(dataResponse))
                    break
                case .failure(let error):
                    guard let data = response.data , let serviceError =  try? JSONDecoder().decode(BaseResponseEntity.self, from: data)  else {
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: error.localizedDescription)))
                    }
                    completion(.failure(ServiceErrorHandler.get(code: serviceError.code, description: serviceError.description)))
                }
            })
        }else{
            completion(.failure(ServiceErrorHandler.getNetworkError()))
        }
    }
    
    func incrementCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity], Error>) -> Void) {
        if Reachability.isConnectedToNetwork(){
            guard let requestRef = request as? CounterIncrementRequestObject else{return}
            let url = AppConfig.serverBaseUrl + requestRef.path
            
            sessionManager?.request(url, method: requestRef.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().debugLog().responseData(completionHandler: { (response) in
                
                let responseStr = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                debugPrint(responseStr ?? "")
                
                switch response.result{
                case .success(let data):
                    guard let dataResponse = try? JSONDecoder().decode([CounterEntity].self, from: data) else{
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: nil)))
                    }
                    completion(.success(dataResponse))
                    break
                case .failure(let error):
                    guard let data = response.data , let serviceError =  try? JSONDecoder().decode(BaseResponseEntity.self, from: data)  else {
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: error.localizedDescription)))
                    }
                    completion(.failure(ServiceErrorHandler.get(code: serviceError.code, description: serviceError.description)))
                }
            })
        }else{
            completion(.failure(ServiceErrorHandler.getNetworkError()))
        }
    }
    
    func decrementCounter(request: RequestObject, completion: @escaping (Swift.Result<[CounterEntity], Error>) -> Void) {
        if Reachability.isConnectedToNetwork(){
            guard let requestRef = request as? CounterDecrementRequestObject else{return}
            let url = AppConfig.serverBaseUrl + requestRef.path
            
            sessionManager?.request(url, method: requestRef.method, parameters: nil, encoding: requestRef.encoding, headers: requestRef.headers).validate().debugLog().responseData(completionHandler: { (response) in
                
                let responseStr = NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue)
                debugPrint(responseStr ?? "")
                
                switch response.result{
                case .success(let data):
                    guard let dataResponse = try? JSONDecoder().decode([CounterEntity].self, from: data) else{
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: nil)))
                    }
                    completion(.success(dataResponse))
                    break
                case .failure(let error):
                    guard let data = response.data , let serviceError =  try? JSONDecoder().decode(BaseResponseEntity.self, from: data)  else {
                        return completion(.failure(ServiceErrorHandler.get(code: nil, description: error.localizedDescription)))
                    }
                    completion(.failure(ServiceErrorHandler.get(code: serviceError.code, description: serviceError.description)))
                }
            })
        }else{
            completion(.failure(ServiceErrorHandler.getNetworkError()))
        }
    }

    
}

extension Request {
    
    public func debugLog() -> Self {
        TimberjackHelper.logBody(_newRequest: self.request!)
        return self
    }
}
