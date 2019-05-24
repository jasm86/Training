//
//  String+Extensions.swift
//  Services
//
//  Created by Jorge Angel Sanchez Martinez on 4/19/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

extension String {
    public func localized() ->  String{
        return NSLocalizedString(self, comment: "")
    }
    
    public func localized(format: CVarArg...) ->  String{
        return String(format: NSLocalizedString(self, comment: ""), format)
    }
}
