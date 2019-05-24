//
//  EntityUpcoming.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

struct EntityUpcoming {
    var error: ConnectionError?
    var results: [SearchResultModel] = []
    
    public static func buildRequest() -> [Parameter]{
        var query: [Parameter] = []
        query.append((key: BuildParams.primaryReleaseDateGte.rawValue, value: "2018-09-15"))
        query.append((key: BuildParams.primaryReleaseDateLte.rawValue, value: "2018-10-22"))    
        return query
    }
}
