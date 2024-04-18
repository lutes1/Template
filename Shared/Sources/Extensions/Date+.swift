//
//  File.swift
//  
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation

public extension Date {
    func toUtcString() -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
    
    func toString(formatterType: FormatterType) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = formatterType.rawValue
        return formatter.string(from: self)
    }
    
    enum FormatterType: String {
        case shortStringMonthAndDay = "MMM dd"
        case longMonthDayTime = "MMM d, h:mm a"
        case time = "h:mm a"
        case date = "MM.dd.YYYY"
    }
}
