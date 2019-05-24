//
//  EntityMostRated.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

struct EntityMostRated{
    var error: ConnectionError?
    var results: [SearchResultModel] = []
    
    public static func buildRequest() -> [Parameter]{
        var query: [Parameter] = []
        query.append((key: BuildParams.certificationCountry.rawValue, value: "popularity.desc"))
        query.append((key: BuildParams.certification.rawValue, value: "R"))
        query.append((key: BuildParams.sortBy.rawValue, value: "vote_average.desc"))                
        return query
    }
    
}
