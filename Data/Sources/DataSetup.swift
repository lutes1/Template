//
//  DataRegisterer.swift
//  Data
//
//  Created by Petru Lutenco on 31.10.2023.
//

import Papyrus
import Foundation
import Shared
import Domain
import PublicInitialiserMacro
import KeychainAccess
import os

@PublicInitialiser
public class DataSetup: RegistererProtocol {
    public func setup(with container: DIContainer) {
        // The order matters for autoregistration
        _registerStorages(in: container)
        _registerEnvironmentService(in: container)
        _registerApis(in: container)
        _registerNetworkErrorServices(in: container)
        _registerRepositories(in: container)
        
        _checkFirstLaunch(container)
    }
    
    private func _registerApis(in container: DIContainer) {
        container.register(AuthorizationInterceptor.self, with: AuthorizationInterceptor.init)
        container.register(Provider.self, factory: _initializeNetworkProvider)
        container.register(AppUpdateApiProtocol.self, with: AppUpdateApiProtocolAPI.init, scope: .singleton)
        container.register(MoviesApiProtocol.self, with: MoviesApiProtocolAPI.init, scope: .singleton)
    }
    
    private func _initializeNetworkProvider(resolver: DIResolver) -> Provider {
        let environmentService = resolver.resolve(EnvironmentServiceProtocol.self)
        let authorizationInterceptor = resolver.resolve(AuthorizationInterceptor.self)
        
        let baseUrl = environmentService.getSelectedEnvironment().baseUrl
        let urlSession = URLSession.shared
        urlSession.configuration.waitsForConnectivity = true
        urlSession.configuration.timeoutIntervalForRequest = 60
        urlSession.configuration.timeoutIntervalForResource = 60 * 60
        
        return Provider(baseURL: baseUrl, urlSession: urlSession, interceptors: [authorizationInterceptor])
    }
    
    private func _registerNetworkErrorServices(in container: DIContainer) {
        container.register(NetworkErrorDecodingServiceProtocol.self, with: NetworkErrorDecodingService.init, scope: .singleton)
    }
    
    private func _registerEnvironmentService(in container: DIContainer) {
        container.register(EnvironmentServiceProtocol.self, with: EnvironmentService.init)
    }
    
    private func _registerStorages(in container: DIContainer) {
        let userDefaultsService: UserDefaults = UserDefaults.standard
        container.register(UserDefaults.self, as: userDefaultsService, scope: .singleton)
        
        container.register(LocalStorageRepositoryProtocol.self, with: LocalStorageRepository.init, scope: .singleton)
        
        let keychainService: Keychain = Keychain(service: String(describing: Bundle.main.bundleIdentifier))
        container.register(Keychain.self, as: keychainService, scope: .singleton)
        
        container.register(KeychainServiceProtocol.self, with: KeychainService.init, scope: .singleton)
        container.register(SecureStorageRepositoryProtocol.self, with: SecureStorageRepository.init, scope: .singleton)
    }

    private func _registerRepositories(in container: DIContainer) {
        container.register(AppUpdateRepositoryProtocol.self, with: AppUpdateRepository.init, scope: .singleton)
        container.register(MoviesRepositoryProtocol.self, with: MoviesRepository.init, scope: .singleton)
    }
    
    private func _checkFirstLaunch(_ container: DIContainer) {
        let logger = DIContainer.shared.resolve(Logger.self)
        let localStorageRepo = container.resolve(LocalStorageRepositoryProtocol.self)
        
        if !localStorageRepo.wasPreviouslyLaunched {
            logger.info("App launched for the first time")
            let keychainService = container.resolve(SecureStorageRepositoryProtocol.self)
            keychainService.clean()
            
            localStorageRepo.wasPreviouslyLaunched = true
            logger.info("wasPreviouslyLaunched set to true ")
        }
    }
}
