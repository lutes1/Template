//
//  EnvironmentSettingsViewModelMock.swift
//  Core
//
//  Created by vadim josan on 22.11.2023.
//

import Foundation
import Domain

class EnvironmentSettingsViewModelMock: EnvironmentSettingsViewModelProtocol {
    func initialize(_ actions: EnvironmentSettingsPageActionsProtocol) { }
    
    var selectedEnv: AppEnvironment = AppEnvironment.dev
    var allEnvironments: [AppEnvironment] = AppEnvironment.allCases
    
    func isSelected(env: AppEnvironment) -> Bool {
        return false
    }
    
    func done() { }
    
    func select(_ item: AppEnvironment) { }
}
