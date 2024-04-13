//
//  AppSetup.swift
//  Template
//
//  Created by vadim josan on 16.11.2023.
//

import Foundation
import Domain
import Shared
import Data
import Core
import UIKit

public class AppSetup {
    
    private static let _registerers: [RegistererProtocol] = [
        SharedSetup(),
        DataSetup(),
        DomainSetup(),
        CoreSetup()
    ]
    
    public static func setup() {
        
        let container = DIContainer.shared
        
        _registerFirst(container: container)
        
        for registerer in _registerers {
            registerer.setup(with: container)
        }
    }
    
    private static func _registerFirst(container: DIContainer) {
        container.register(
            ToastProviderProtocol.self,
            with: ToastProvider.init,
            scope: .singleton
        )
        
        container.register(
            AnimationProviderProtocol.self,
            with: AnimationProvider.init,
            scope: .singleton
        )

        container.register(
            UrlLauncherProviderProtocol.self,
            with: UrlLauncherProvider.init,
            scope: .singleton
        )
        
        container.register(DeviceTypeProtocol.self, with: DeviceType.init, scope: .singleton)
        
        let appCoordinator = AppCoordinator.init()
        container.register(ApplicationCoordinatorProtocol.self, as: appCoordinator,scope: .singleton)
        container.register(AppCoordinator.self, as: appCoordinator, scope: .singleton)
        
        container.register(DialogServiceProtocol.self, with: DialogService.init, scope: .singleton)
    }
}
