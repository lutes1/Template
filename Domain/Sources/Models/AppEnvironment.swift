//
//  AppEnvironment.swift
//  Domain
//
//  Created by vadim josan on 23.11.2023.
//

import Foundation

public enum AppEnvironment: Int, CaseIterable {
    case prod = 1
    case stage
    case dev
    
    public var baseUrl: String {
        switch self {
            case .prod:
                EnvironmentUrls.prod
            case .stage:
                EnvironmentUrls.stage
            case .dev:
                EnvironmentUrls.dev
        }
    }
    
    public var name: String {
        switch self {
            case .prod:
                "Production"
            case .stage:
                "Stage"
            case .dev:
                "Develop"
        }
    }
}
