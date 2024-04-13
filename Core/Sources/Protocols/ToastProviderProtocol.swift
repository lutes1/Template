//
//  ToastProviderProtocol.swift
//  Core
//
//  Created by vadim josan on 21.11.2023.
//

import Foundation

public protocol ToastProviderProtocol {
    @MainActor
    func showToast(message: String) async
    
    @MainActor
    func showError(message: String) async
    
    @MainActor
    func showWarning(message: String) async
}
