//
//  AppUpdateRepositoryProtocol.swift
//  
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation

public protocol AppUpdateRepositoryProtocol {
    func checkAppVersion() async throws -> AppUpdateModel
    func updateLastCheckedAppVersion() throws
}
