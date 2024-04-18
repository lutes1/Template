//
//  File.swift
//  
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation

extension JSONDecoder {
    public static var apiDateDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.apiFormatter)
        return decoder
    }
}

extension DateFormatter {
    public static var apiFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
}
