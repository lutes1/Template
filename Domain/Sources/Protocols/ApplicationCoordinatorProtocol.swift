//
//  ApplicationCoordinatorProtocol.swift
//  Domain
//
//  Created by Petru Lutenco on 07.12.2023.
//

import Foundation

@MainActor
public protocol ApplicationCoordinatorProtocol {
    func presentLoginScreen()
    func showUpdateDialogue(model: AppUpdateDialogModel)
}
