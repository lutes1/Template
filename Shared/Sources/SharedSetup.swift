//
//  SharedRegisterer.swift
//  Shared
//
//  Created by Petru Lutenco on 12.11.2023.
//

import Foundation
import PublicInitialiserMacro
import os
import Instabug

@PublicInitialiser
public class SharedSetup: RegistererProtocol {
    public func setup(with container: DIContainer) {
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Template")
        container.register(Logger.self, as: logger, scope: .singleton)
        container.register(AnalyticsServiceProtocol.self, with: AnalyticsService.init, scope: .singleton)
        
        #if !DEBUG
        _setupInstabug(logger: logger)
        #endif
    }
    
    private func _setupInstabug(logger: os.Logger) {
        let token: String
        
        if Bundle.main.isAppStore {
            token = "production_app_token"
            logger.log("Starting instabug for appstore!")
        } else {
            token = "development_app_token"
            logger.log("Starting instabug for development!")
        }
    
        CrashReporting.unhandledEnabled = false
        
        Instabug.start(withToken: token, invocationEvents: [.shake, .screenshot])
        
        BugReporting.shakingThresholdForiPad = 1.0
        BugReporting.promptOptionsEnabledReportTypes = [.bug, .feedback]
        BugReporting.shouldCaptureViewHierarchy = true
        APM.uiHangsEnabled = false
    }
}
