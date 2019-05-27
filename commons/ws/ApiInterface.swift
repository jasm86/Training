//
//  Api.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

typealias Parameter = (key: String, value: String)

protocol ApiInterface {
    typealias Endpoint = String
    static var baseUrl: URL? { get }
    
}

protocol ConnectionInterface{
    typealias ConnectionCompletionHandler = (Data?, ConnectionError?) -> Void
    typealias PathComponent = String
    typealias Endpoint = String
    
    func get(endPoint: Endpoint?, parameters: [Parameter], completion: ConnectionCompletionHandler?)
    func post<T>(endPoint: Endpoint?, parameter: T,pathComponents: PathComponent..., completion: ConnectionCompletionHandler?) where T : Codable
}

enum ConnectionError: Error {
    case error(message: String)
    case connectionError(code: Int)
    case connectionFail
}
