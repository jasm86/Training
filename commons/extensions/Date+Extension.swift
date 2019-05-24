//
//  Date+Extension.swift
//  Services
//
//  Created by Jorge Angel Sanchez Martinez on 5/15/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import Foundation

extension Date{
    
    public func format(to format:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    public static func format(to format:String, date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public static func parse(from format:String, dateStr: String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateStr)
    }
}
