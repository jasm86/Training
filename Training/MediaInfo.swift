//
//  MediaInfo.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/26/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation


enum Sections {
    case mostPopular
    case mostRated
    case upcoming
    
    public var description: String {
        switch self {
            case .mostPopular:
                return "mostPopular".localized()
            case .mostRated:
                return "mostRated".localized()
            case .upcoming:
                return "upcoming".localized()            
        }
    }
}
