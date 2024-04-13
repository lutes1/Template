//
//  Logger.swift
//  Shared
//
//  Created by Petru Lutenco on 12.11.2023.
//

import Foundation
import os

public protocol AnalyticsServiceProtocol {
    func track(event: AnalyticsEvents)
    func track(event: AnalyticsEvents, properties: [String: String])

    func track(error: Error)
    func track(_ error: Error, message: String)
    func track(error: Error, properties: [String: String])
    
    func track(errorMessage: String)
    func track(errorMessage: String, properties: [String: String])
}

// TODO: Implement with analytics provider
class AnalyticsService : AnalyticsServiceProtocol {
    private let _logger: os.Logger
    
    init(logger: os.Logger) {
        _logger = logger
    }
    
    func track(event: AnalyticsEvents) {
        // TODO: Integrate analytics service
    }
    
    func track(event: AnalyticsEvents, properties: [String: String]) {
        // TODO: Integrate analytics service
    }
    
    func track(error: Error) {
        // TODO: Integrate analytics service
        _logger.error("\(error, privacy: .public)")
    }
    
    func track(_ error: Error, message: String) {
        // TODO: Integrate analytics service
        _logger.error("\(message, privacy: .public)")
    }

    func track(error: Error, properties: [String: String]) {
        // TODO: Integrate analytics service
        _logger.error("\(error, privacy: .public)")
    }
    
    func track(errorMessage: String) {
        // TODO: Integrate analytics service
        _logger.error("\(errorMessage, privacy: .public)")
    }
    
    func track(errorMessage: String, properties: [String: String]) {
        // TODO: Integrate analytics service
        _logger.error("\(errorMessage, privacy: .public)")
    }
}
