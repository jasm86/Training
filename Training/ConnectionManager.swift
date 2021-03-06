//
//  ConnectionManager.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation
import UIKit

class ConnectionManager:  ConnectionInterface{
    private var defaultSession: URLSession?
    public static let shared: ConnectionInterface? = {
        
        guard let url = Api.baseUrl else {
            return nil
        }
        let connectionManager = ConnectionManager()
        return connectionManager
    }()
    
    private init() {
        let config: URLSessionConfiguration = .default
        defaultSession = URLSession(configuration: config)
    }
    
    public func get(endPoint: Endpoint? = nil, parameters: [Parameter], completion: ConnectionCompletionHandler? = nil){
        guard let url = Api.baseUrl else {
            completion?(nil, .connectionFail)
            return
        }
        var completeUrl = url.absoluteString
        if let endPoint = endPoint {
            completeUrl.append(endPoint)
        }
        completeUrl.append("?")
        
        if var urlComponents = URLComponents(string: completeUrl) {
            var completeParams: String = ""
            for parameter in parameters {
                completeParams.append(parameter.key)
                completeParams.append("=")
                completeParams.append(parameter.value)
                completeParams.append("&")
            }
            urlComponents.query = completeParams
            let dataTask = defaultSession?.dataTask(with: urlComponents.url ?? url) {data, response, error in
                if let completion = completion {
                    var error: ConnectionError?
                    if let _ = data, let response = response as? HTTPURLResponse {
                        if response.statusCode != 200 {
                            error = .connectionError(code: response.statusCode)
                        }
                    }else{
                        error = .connectionFail
                    }
                    completion(data, error)
                }
            }
            dataTask?.resume()
        }
    }
    
    func post<T>(endPoint: Endpoint? = nil, parameter: T, pathComponents: PathComponent..., completion: ConnectionCompletionHandler? = nil) where T : Codable{
        guard let url = Api.baseUrl else {
            completion?(nil, .connectionFail)
            return
        }
        var completeUrl = url.absoluteString
        if let endPoint = endPoint {
            completeUrl.append("/")
            completeUrl.append(endPoint)
        }
        
        for pathComponent in pathComponents{
            completeUrl.append("/")
            completeUrl.append(pathComponent)
        }
        print(completeUrl)
        if let urlComponents = URLComponents(string: completeUrl) {
            var request = URLRequest(url: urlComponents.url ?? url)
            request.httpMethod = "POST"
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
            let encoder = JSONEncoder()
            do {
                let jsonData = try encoder.encode(parameter)
                request.httpBody = jsonData
                print("request : ", String(data: request.httpBody!, encoding: .utf8) )
            } catch {
                completion?(nil, .connectionFail)
            }
            let dataTask = defaultSession?.dataTask(with: request) {data, response, error in
                if let completion = completion {
                    var error: ConnectionError?
                    if let _ = data, let response = response as? HTTPURLResponse {
                        if response.statusCode != 200 {
                            error = .connectionError(code: response.statusCode)
                        }
                    }else{
                        error = .connectionFail
                    }
                    completion(data, error)
                }
            }
            dataTask?.resume()
        }
    }
}
