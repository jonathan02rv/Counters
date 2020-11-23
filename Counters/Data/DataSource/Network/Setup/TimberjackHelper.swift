//
//  TimberjackHelper.swift
//  Counters
//
//  Created by Jhonatahan on 11/18/20.
//

import Foundation

open class TimberjackHelper: URLProtocol{

    //MARK: - Log
    
    class func logDivider() {
        print("---------------------")
    }
    
    class open func logRequest(_ request: URLRequest) {
         TimberjackHelper.logDivider()
        
        if let url = request.url?.absoluteString {
            print("Request: \(request.httpMethod!) \(url)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            self.logHeaders(headers as [String : AnyObject])
        }
    }
    
    class func logHeaders(_ headers: [String: AnyObject]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key) : \(value)")
        }
    }
    
    class func logBody(_newRequest:URLRequest){
        
        DispatchQueue.global(qos: .background).async {
            
            TimberjackHelper.logRequest(_newRequest)
            print("====================")
            print("BODY")
            
            if(_newRequest.httpBody != nil){
                let body = String(data: (_newRequest.httpBody)!, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                print(body)
            }
        }
    }
}
