//
//  KeychainService.swift
//  Data
//
//  Created by vadim josan on 07.11.2023.
//

import Foundation
import KeychainAccess
import Shared
import os

protocol KeychainServiceProtocol {
    func set(key: String, value: String?)
    func get(key: String) -> String?
    func remove(key: String) throws
    func clean()
}

class KeychainService: KeychainServiceProtocol {
    private var _keychain: Keychain
    private var _logger: Logger
    private var _anayticService: AnalyticsServiceProtocol
    
    init(
        keychain: Keychain,
        logger: Logger,
        anayticService: AnalyticsServiceProtocol
    ) {
        _keychain = keychain
        _logger = logger
        _anayticService = anayticService
    }
    
    func set(key: String, value: String?) {
        _keychain[string: key] = value
    }
    
    func get(key: String) -> String? {
        _keychain[string: key]
    }
    
    func remove(key: String) throws {
        try _keychain.remove(key)
    }
    
    func clean() {
        do {
            try _keychain.removeAll()
            
            _logger.info("Keychain cleaned up after a fresh install")
        }
        catch {
            _anayticService.track(error: error)
        }
    }
}
