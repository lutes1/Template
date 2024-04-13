//
//  EnvironmentService.swift
//  Data
//
//  Created by vadim josan on 23.11.2023.
//

import Foundation
import Shared
import Domain

public protocol EnvironmentServiceProtocol {
    func setEnvironment(_ env: AppEnvironment)
    func getSelectedEnvironment() -> AppEnvironment
}

class EnvironmentService: EnvironmentServiceProtocol {
    private var _selectedEnvironment: AppEnvironment?
    private var _localStorage: LocalStorageRepositoryProtocol
    
    init(localStorage: LocalStorageRepositoryProtocol) {
        _localStorage = localStorage
    }
    
    func setEnvironment(_ env: AppEnvironment) {
        _selectedEnvironment = env
        _localStorage.setSelectedEnvironment(env)
        DIContainer.shared.invalidate(.singleton)
    }
    
    func getSelectedEnvironment() -> AppEnvironment {
        if Bundle.main.isAppStore {
            return .prod
        }
        
        let defaultEnvironment: AppEnvironment
        
        #if DEBUG
        defaultEnvironment = .dev
        #else
        defaultEnvironment = .prod
        #endif
        
        return _selectedEnvironment ?? _localStorage.selectedEnvironment ?? defaultEnvironment
    }
}
