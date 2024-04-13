//
//  UIApplicationErrors.swift
//  Template
//
//  Created by Petru Lutenco on 17.11.2023.
//

import Foundation

enum UIApplicationErrors: Error, CustomStringConvertible {
    case invalidRootViewController
    case topViewControllerNotFound
    
    var description: String {
        switch self {
        case .invalidRootViewController:
            "Unable to locate the root view controller"
        case .topViewControllerNotFound:
            "Unable to locate the top view controller"
        }
    }
}
