//
//  AnimationProvider.swift
//  Template
//
//  Created by vadim josan on 04.12.2023.
//

import SwiftUI
import Core

@MainActor
class AnimationProvider: AnimationProviderProtocol {
    nonisolated init() {}
    
    func animating(block: () -> Void) {
        withAnimation {
            block()
        }
    }
    
    func animateThrowing(block: () throws -> Void) throws {
        try withAnimation {
            try block()
        }
    }
}
