//
//  SearchBuilder.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation


enum BuildParams: String  {
    case sortBy = "sort_by"
    case certificationCountry = "certification_country"
    case certification = "certification"
    case primaryReleaseDateGte = "primary_release_date.gte"
    case primaryReleaseDateLte = "primary_release_date.lte"
}
