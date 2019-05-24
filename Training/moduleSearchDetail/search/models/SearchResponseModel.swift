//
//  SearchResultModel.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

class SearchResponseModel: Codable{
    var page: UInt16?
    var totalResults: UInt32?
    var totalPages: UInt32?
    var results: [SearchResultModel]?
    
    enum CodingKeys : String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}
