//
//  SecureStorageRepository.swift
//  Data
//
//  Created by vadim josan on 06.11.2023.
//

import Foundation
import Domain
import Shared
import os

class SecureStorageRepository: SecureStorageRepositoryProtocol {
    
    private var _keychainService: KeychainServiceProtocol
    
    private var _accessTokenCache: String?
    private var _expirationDateCache: Date?
    private let _logger: Logger
    
    init(keychainService: KeychainServiceProtocol, logger: Logger) {
        _keychainService = keychainService
        _logger = logger
    }
    
    func removeAccountData() throws {
        _logger.info("Removing account data")
    }
    
    func clean() {
        _logger.info("Cleaning the keychain")
        _keychainService.clean()
    }
}
