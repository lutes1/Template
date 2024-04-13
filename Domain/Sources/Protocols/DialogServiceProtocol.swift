//
//  DialogServiceProtocol.swift
//  Domain
//
//  Created by Petru Lutenco on 07.12.2023.
//

import Foundation

public protocol DialogServiceProtocol {
    @MainActor
    func showAlert(title: String, message: String, confirmTitle: String) async
    
    @MainActor
    func showAlertWithDistructiveConfirmation(title: String, message: String, confirmTitle: String, dismissTitle: String) async -> Bool
    
    @MainActor
    func showAlertWithConfirmation(title: String, message: String, confirmTitle: String, dismissTitle: String) async -> Bool
    
    @MainActor
    func showAlertForSelectPhoto(onSelectCamera: @escaping () -> Void, onSelectGallery: @escaping () -> Void)

    @MainActor
    func showAlertWithDissmisOnTop(title: String, message: String, options: [String], dismissTitle: String) async -> Int?
}
