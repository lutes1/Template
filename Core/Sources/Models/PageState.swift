//
//  PageState.swift
//
//
//  Created by Petru Lutenco on 30.01.2024.
//

import Foundation

public enum PageState : Equatable {
    case loading
    case ready
    case error(String)
    
    public var isReady: Bool {
        self == .ready
    }
}
