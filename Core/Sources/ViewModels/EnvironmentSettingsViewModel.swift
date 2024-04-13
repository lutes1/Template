//
//  EnvironmentSettingsViewModel.swift
//  Core
//
//  Created by vadim josan on 22.11.2023.
//

import Foundation
import Data
import Domain
import Shared

public protocol EnvironmentSettingsPageActionsProtocol {
    func close()
    func reloadAuthPage()
}

public protocol EnvironmentSettingsViewModelProtocol {
    var selectedEnv: AppEnvironment { get set }
    var allEnvironments: [AppEnvironment] { get }
    func done()
    func select(_ item: AppEnvironment)
    func isSelected(env: AppEnvironment) -> Bool
    func initialize(_ actions: EnvironmentSettingsPageActionsProtocol)
}

@Observable
class EnvironmentSettingsViewModel: EnvironmentSettingsViewModelProtocol {
    private var _actions: EnvironmentSettingsPageActionsProtocol!
    private var _environmentService: EnvironmentServiceProtocol
    var selectedEnv: AppEnvironment
    var allEnvironments: [AppEnvironment] = AppEnvironment.allCases.filter { !$0.baseUrl.isEmpty }
    
    init(environmentService: EnvironmentServiceProtocol) {
        _environmentService = environmentService
        selectedEnv = environmentService.getSelectedEnvironment()
    }
    
    func initialize(_ actions: EnvironmentSettingsPageActionsProtocol) {
        _actions = actions
    }
    
    func done() {
        _actions.close()
    }
    
    func select(_ env: AppEnvironment) {
        guard env != selectedEnv else {
            return
        }
        
        selectedEnv = env
        _environmentService.setEnvironment(env)
        _actions.reloadAuthPage()
    }
    
    func isSelected(env: AppEnvironment) -> Bool {
        return env == selectedEnv
    }
}
