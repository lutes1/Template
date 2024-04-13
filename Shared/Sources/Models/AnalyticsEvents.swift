//
//  AnalyticsEvents.swift
//  Shared
//
//  Created by Petru Lutenco on 15.11.2023.
//

import Foundation

public enum AnalyticsEvents {
    case templateEvent(metadata: String)
    
    var name: String {
        switch self {
        case .templateEvent(let metadata):
            "Template event with \(metadata)"
        }
    }
}
