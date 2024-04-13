//
//  AnimationProvider.swift
//  Core
//
//  Created by vadim josan on 04.12.2023.
//

import Foundation

@MainActor
public protocol AnimationProviderProtocol {
    func animating(block: () -> Void)
    func animateThrowing(block: () throws -> Void) throws
}
