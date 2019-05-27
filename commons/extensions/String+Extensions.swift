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
    
    func indices(of occurrence: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: occurrence, range: position..<endIndex) {
            let i = distance(from: startIndex,
                             to: range.lowerBound)
            indices.append(i)
            let offset = occurrence.distance(from: occurrence.startIndex,
                                             to: occurrence.endIndex) - 1
            guard let after = index(range.lowerBound,
                                    offsetBy: offset,
                                    limitedBy: endIndex) else {
                                        break
            }
            position = index(after: after)
        }
        return indices
    }
}
