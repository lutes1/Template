//
//  File.swift
//  
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation
import Domain

class AppUpdateRepository: AppUpdateRepositoryProtocol {
    private let _appUpdateApi: AppUpdateApiProtocol
    private let _localStorageRepository: LocalStorageRepositoryProtocol
    
    init(
        appUpdateApi: AppUpdateApiProtocol,
        localStorageRepository: LocalStorageRepositoryProtocol
    ) {
        _appUpdateApi = appUpdateApi
        _localStorageRepository = localStorageRepository
    }
    
    func checkAppVersion() async throws -> AppUpdateModel {
        let currentAppVersion = try _appVersion()
        
        let apiAppVersion = try await _appUpdateApi.checkAppVersion(appVersion: currentAppVersion)
        
        let appVersionModel = AppUpdateModel(
            hasNewVersion: apiAppVersion.hasNewVersion,
            shouldForceUpdate: apiAppVersion.shouldForceUpdate,
            wasUpdatePresentedForTheCurrentVersion: _localStorageRepository.presentedUpdateVersion == currentAppVersion
        )
        
        return appVersionModel
    }
    
    func updateLastCheckedAppVersion() throws {
        _localStorageRepository.presentedUpdateVersion = try _appVersion()
    }
    
    private func _appVersion() throws -> String {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            throw AppVersionErrors.unableToGetInfoDictionaryFromBundle
        }
        
        guard let appVersion = infoDictionary["CFBundleShortVersionString"] as? String else {
            throw AppVersionErrors.unableToGetAppVersionFromInfoDictionary
        }
        
        return appVersion
    }
}
