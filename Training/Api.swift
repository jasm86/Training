//
//  Api.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation
class Api: ApiInterface{
    static let key = "42da555c2feb644c6ed275ab2c138235"
    static var baseUrl: URL? {
        guard let url = URL.init(string: "https://api.themoviedb.org/3/discover/movie") else {
            return nil
        }
        return url
    }
}
