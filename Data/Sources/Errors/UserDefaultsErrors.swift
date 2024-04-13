//
//  UserDefaultsErrors.swift
//  
//
//  Created by Petru Lutenco on 05.03.2024.
//

import Foundation

enum UserDefaultsErrors: Error, CustomStringConvertible {
    case noValueWasFoundForKey(String)
    
    var description: String {
        switch self {
        case .noValueWasFoundForKey(let key):
            "No codable value was found for key: \(key)"
        }
    }
}
