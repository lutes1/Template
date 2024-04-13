//
//  AppUpdateModel.swift
//
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation

public struct AppUpdateModel {
    public init(hasNewVersion: Bool, shouldForceUpdate: Bool, wasUpdatePresentedForTheCurrentVersion: Bool) {
        self.hasNewVersion = hasNewVersion
        self.shouldForceUpdate = shouldForceUpdate
        self.wasUpdatePresentedForTheCurrentVersion = wasUpdatePresentedForTheCurrentVersion
    }
    
    public let hasNewVersion: Bool
    public let shouldForceUpdate: Bool
    public let wasUpdatePresentedForTheCurrentVersion: Bool
}
