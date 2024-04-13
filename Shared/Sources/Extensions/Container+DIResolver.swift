//
//  Container+DIResolver.swift
//  Shared
//
//  Created by Petru Lutenco on 23.11.2023.
//

import Foundation
import Swinject

extension Container: DIResolver {
    public func resolve<T>(_ type: T.Type) -> T {
        guard let resolved = resolve(type) else {
            fatalError(
                """
                Type \(type) was not registered in the container.
                Please use one of the provided registration methods.
                """
            )
        }
        
        return resolved
    }
}
