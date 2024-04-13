//
//  AppUpdateUseCase.swift
//
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation
import Shared

public protocol AppUpdateUseCaseProtocol {
    func checkAppVersion(appCoordinator: ApplicationCoordinatorProtocol)
}

class AppUpdateUseCase: AppUpdateUseCaseProtocol {
    
    private let _appVersionRepository: AppUpdateRepositoryProtocol
    private let _dialogServiceProtocol: DialogServiceProtocol
    private let _urlLauncher: UrlLauncherProviderProtocol
    private let _analyticsService: AnalyticsServiceProtocol
    
    init(
        appVersionRepository: AppUpdateRepositoryProtocol,
        dialogServiceProtocol: DialogServiceProtocol,
        urlLauncher: UrlLauncherProviderProtocol,
        analyticsService: AnalyticsServiceProtocol
    ) {
        _appVersionRepository = appVersionRepository
        _dialogServiceProtocol = dialogServiceProtocol
        _urlLauncher = urlLauncher
        _analyticsService = analyticsService
    }
    
    func checkAppVersion(appCoordinator: ApplicationCoordinatorProtocol) {
        Task {
            do {
                let appUpdate = try await _appVersionRepository.checkAppVersion()
                
                guard appUpdate.hasNewVersion else {
                    return
                }
                
                guard !appUpdate.wasUpdatePresentedForTheCurrentVersion || appUpdate.shouldForceUpdate else {
                    return
                }
                
                let title = appUpdate.shouldForceUpdate
                    ? "Update Required"
                    : "Update Available"
                    
                let message = appUpdate.shouldForceUpdate
                    ? "We’ve launched a new and improved version of the app. Please update to continue using the app."
                    : "We’ve launched a new and improved version of the app. Would you like to update it now?"
                
                let updateModel: AppUpdateDialogModel = .init(
                    title: title,
                    message: message,
                    confirmAction: showAppInAppStore,
                    isForceUpdate: appUpdate.shouldForceUpdate
                )
                
                await appCoordinator.showUpdateDialogue(model: updateModel)
                
                try _appVersionRepository.updateLastCheckedAppVersion()
            } catch {
                _analyticsService.track(error, message: "An error occurred while checking for a new app version")
            }
        }
    }
    
    func showAppInAppStore() {
        do {
            try _urlLauncher.showAppInAppStore()
        } catch {
            _analyticsService.track(error, message: "Unable to open App Store link")
        }
    }
}
