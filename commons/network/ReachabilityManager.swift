//
//  RechabilityManager.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager<T: ApiInterface>{
    static var shared: ReachabilityManager {
        return ReachabilityManager()
    }
    fileprivate var reachability: Reachability{
        let reachability = Reachability(hostname: T.baseUrl?.scheme ?? "google.com")!
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        return reachability
    }
    private init() {
        
    }
    
    func stopNotifier() -> Void {
        reachability.stopNotifier()
    }
    
    func isReachable() -> Bool {
        return reachability.connection != .none
    }
    
    func isUnreachable() -> Bool {
        return reachability.connection == .none
    }
}

