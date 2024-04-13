//
//  CoreRegisterer.swift
//  Core
//
//  Created by Petru Lutenco on 31.10.2023.
//

import Foundation
import Shared
import PublicInitialiserMacro

@PublicInitialiser
public class CoreSetup: RegistererProtocol {
    public func setup(with container: DIContainer) {
        container.register(
            EnvironmentSettingsViewModelProtocol.self,
            with: EnvironmentSettingsViewModel.init
        )
        container.registerMock(
            EnvironmentSettingsViewModelProtocol.self,
            with: EnvironmentSettingsViewModelMock.init
        )
        
        container.register(HomeViewModelProtocol.self, with: HomeViewModel.init)
    }
}
