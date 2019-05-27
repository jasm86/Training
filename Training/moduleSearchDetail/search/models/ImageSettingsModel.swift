//
//  ImageSettingsModel.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/27/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation
class ImageSettingsModel: Codable{    
    var baseUrl: String?
    var secureBaseUrl: String?
    var backdropSizes: [String]?
    var logoSizes: [String]?
    var posterSizes: [String]?
    var profileSizes: [String]?
    var stillSizes: [String]?
    
    enum CodingKeys : String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
