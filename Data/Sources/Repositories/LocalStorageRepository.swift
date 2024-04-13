//
//  UserDefaultsStorage.swift
//  Data
//
//  Created by vadim josan on 06.11.2023.
//

import Foundation
import Domain
import Shared

final class LocalStorageRepository: LocalStorageRepositoryProtocol {
    
    private var _userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        _userDefaults = userDefaults
    }
    
    var selectedEnvironment: AppEnvironment? {
        get {
            let selectedEnvironmentRawValue = _userDefaults.integer(forKey: StorageKeys.Environment.selectedEnvironment)

            return AppEnvironment(rawValue: selectedEnvironmentRawValue)
        } 
    }
    
    func setSelectedEnvironment(_ env: AppEnvironment) {
        _userDefaults.setValue(env.rawValue, forKey: StorageKeys.Environment.selectedEnvironment)
    }
    
    var wasPreviouslyLaunched: Bool {
        get {
            _userDefaults.bool(forKey: StorageKeys.wasPreviouslyLaunched)
        }
        set {
            _userDefaults.setValue(newValue, forKey: StorageKeys.wasPreviouslyLaunched)
        }
    }
    
    var presentedUpdateVersion: String? {
        get {
            _userDefaults.string(forKey: StorageKeys.presentedUpdateVersion)
        }
        set {
            _userDefaults.setValue(newValue, forKey: StorageKeys.presentedUpdateVersion)
        }
    }
    
    func set<T: Codable>(_ item: T, for key: String) throws {
        try _userDefaults.setCodable(item, forKey: key)
    }
    
    func get<T: Codable>(key: String) throws -> T {
        try _userDefaults.getCodable(forKey: key)
    }
}
