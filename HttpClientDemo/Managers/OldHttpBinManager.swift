//
//  OldHttpBinManager.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import Alamofire

class OldHttpBinManager {
    static let shared = OldHttpBinManager()
    
    private let headers: HTTPHeaders = [
        "APIKey": "API_KEY",
        "Accept": "application/json"
    ]
    
    /// Get an Json Object from HttpBin server.
    ///
    /// - Parameters:
    ///   - onSuccess: onSuccess closure
    ///   - onError: return Error
    public func getJsonObjectFromHttpBin(onSuccess:@escaping (JsonObject?)->(),
                                         onError:@escaping(_ error:Error)->()) {
        
        // Setup 'url'
        guard let url = HttpBin.get.url else {
            let error = NSError(
                domain: "[HttpBinManager | getJsonObjectFromHttBin]",
                code: 99903,
                userInfo: ["description": "Cannot create endpoint."]
            )
            onError(error)
            return
        }
        
        // Send Request
        AFHttpClient.shared.requestJson(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: self.headers,
            completion: { (result) in
                
                switch result {
                case .success(.object (let response)):
                    // Success
                    print("[HttpBinManager] respone: \(response)")
                    onSuccess(response)
                    
                case .error(let error):
                    // Error Handling
                    onError(error)
                    
                default:
                    let error = NSError(
                        domain: "[HttpBinManager | getJsonObjectFromHttBin]",
                        code: 99904,
                        userInfo: ["description": "Can't get a json object."]
                    )
                    onError(error)
                }
            }
        )
    }
    
    /// Get an HttpBinResponse from HttpBin server.
    ///
    /// - Parameters:
    ///   - onSuccess: onSuccess closure
    ///   - onError: return Error
    public func getHttpBinResponse(onSuccess:@escaping (HttpBinResponse?)->(),
                                   onError:@escaping(_ error:Error)->()) {
        
        // Setup 'url'
        guard let url = HttpBin.get.url else {
            let error = NSError(
                domain: "[HttpBinManager | getJsonObjectFromHttBin]",
                code: 99903,
                userInfo: ["description": "Cannot create endpoint."]
            )
            onError(error)
            return
        }
        
        // Send Request
        AFHttpClient.shared.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: self.headers,
            completion: { (result: HttpResult<HttpBinResponse>) in
                
                switch result {
                case .success(let response):
                    // Success
                    print("[HttpBinManager] respone: \(response)")
                    onSuccess(response)
                    
                case .error(let error):
                    // Error Handling
                    onError(error)
                }
            }
        )
    }
}
