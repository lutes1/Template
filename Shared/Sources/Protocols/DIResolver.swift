//
//  DIResolver.swift
//  Shared
//
//  Created by Petru Lutenco on 23.11.2023.
//

import Foundation

public protocol DIResolver {
    func resolve<T>(_ type: T.Type) -> T
}
