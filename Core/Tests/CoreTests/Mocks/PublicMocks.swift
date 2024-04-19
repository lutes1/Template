//
//  PublicMocks.swift
//
//
//  Created by vadim josan on 29.02.2024.
//

@testable import Core
import Foundation
import Domain
import Shared

class ToastProviderMock: ToastProviderProtocol {
    nonisolated init() {}
    
    func showWarning(message: String) {
    }
    
    func showToast(message: String) {
    }
    
    func showError(message: String) {
    }
}

class AnalyticsServiceMock: AnalyticsServiceProtocol {
    
    var trackCalledCount: Int = 0
    
    func track(event: Shared.AnalyticsEvents) {
        trackCalledCount += 1
    }
    
    func track(_ error: Error, message: String) {
        trackCalledCount += 1
    }
    
    func track(event: Shared.AnalyticsEvents, properties: [String : String]) {
        trackCalledCount += 1
    }
    
    func track(error: Error) {
        trackCalledCount += 1
    }
    
    func track(error: Error, properties: [String : String]) {
        trackCalledCount += 1
    }
    
    func track(errorMessage: String) {
        trackCalledCount += 1
    }
    
    func track(errorMessage: String, properties: [String : String]) {
        trackCalledCount += 1
    }
}

class AnimationProviderMock: AnimationProviderProtocol {
    nonisolated init() { }
    
    func animateThrowing(block: () throws -> Void) throws {
        try block()
    }
    
    func animating(block: () -> Void) {
        block()
    }
}
