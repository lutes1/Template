//
//  LocalStorageRepositoryProtocol.swift
//  Domain
//
//  Created by vadim josan on 06.11.2023.
//

import Foundation

public protocol LocalStorageRepositoryProtocol: AnyObject {
    
    var selectedEnvironment: AppEnvironment? { get }

    var wasPreviouslyLaunched: Bool { get set }
    
    var presentedUpdateVersion: String? { get set }
    
    func setSelectedEnvironment(_ env: AppEnvironment)
    
    func set<T: Codable>(_ item: T, for key: String) throws
    
    func get<T: Codable>(key: String) throws -> T
}
