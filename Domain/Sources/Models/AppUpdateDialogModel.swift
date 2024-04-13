//
//  AppUpdateDialogModel.swift
//  
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation

public struct AppUpdateDialogModel {
    public init(title: String, message: String, confirmAction: @escaping () -> Void, isForceUpdate: Bool) {
        self.title = title
        self.message = message
        self.confirmAction = confirmAction
        self.isForceUpdate = isForceUpdate
    }
    
    public let title: String
    public let message: String
    public let confirmAction: () -> Void
    public let isForceUpdate: Bool
}
