//
//  DialogService.swift
//  Template
//
//  Created by Petru Lutenco on 07.12.2023.
//

import Foundation
import Domain
import UIKit
import os

class DialogService: DialogServiceProtocol {
    
    private let _logger: Logger
    
    init(logger: Logger) {
        _logger = logger
    }
    
    @MainActor
    func showAlert(title: String, message: String, confirmTitle: String) async {
        await withCheckedContinuation { continuation in
            do {
                let topViewController = try UIApplication.shared.topController
                
                let alertViewController = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
                
                topViewController.present(alertViewController, animated: true)
                
                alertViewController.addAction(
                    .init(
                        title: confirmTitle,
                        style: .default,
                        handler: { _ in
                            continuation.resume()
                        }
                    )
                )
            }
            catch {
                _logger.error("Unable to locate the top view controller")
                return
            }
        }
    }
    
    @MainActor
    func showAlertWithDissmisOnTop(title: String, message: String, options: [String], dismissTitle: String) async -> Int? {
        await withCheckedContinuation { continuation in
            do {
                let topViewController = try UIApplication.shared.topController
                
                let alertViewController = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
                
                topViewController.present(alertViewController, animated: true)
                
                alertViewController.addAction(
                    .init(
                        title: dismissTitle,
                        style: .default,
                        handler: { _ in
                            alertViewController.dismiss(animated: true)
                            continuation.resume(returning: nil)
                        }
                    )
                )
                
                options.forEach { option in
                    alertViewController.addAction(
                        .init(
                            title: option,
                            style: .destructive,
                            handler: { _ in
                                continuation.resume(returning: options.firstIndex(of: option))
                            }
                        )
                    )
                }
            }
            catch {
                _logger.error("Unable to locate the top view controller")
                return
            }
        }
    }
    
    @MainActor
    func showAlertWithDistructiveConfirmation(title: String, message: String, confirmTitle: String, dismissTitle: String) async -> Bool {
        await withCheckedContinuation { continuation in
            do {
                let topViewController = try UIApplication.shared.topController
                
                let alertViewController = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
                
                topViewController.present(alertViewController, animated: true)
                
                alertViewController.addAction(
                    .init(
                        title: dismissTitle,
                        style: .default,
                        handler: { _ in
                            continuation.resume(returning: false)
                        }
                    )
                )
                
                alertViewController.addAction(
                    .init(
                        title: confirmTitle,
                        style: .destructive,
                        handler: { _ in
                            continuation.resume(returning: true)
                        }
                    )
                )
            }
            catch {
                _logger.error("Unable to locate the top view controller")
                return
            }
        }
    }
    
    @MainActor
    func showAlertWithConfirmation(title: String, message: String, confirmTitle: String, dismissTitle: String) async -> Bool {
        await withCheckedContinuation { continuation in
            do {
                let topViewController = try UIApplication.shared.topController
                
                let alertViewController = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
                
                topViewController.present(alertViewController, animated: true)
                
                let dismissAction = UIAlertAction(title: dismissTitle, style: .default) { _ in
                    continuation.resume(returning: false)
                }
                    
                let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                    continuation.resume(returning: true)
                }
                
                alertViewController.addAction(dismissAction)
                alertViewController.addAction(confirmAction)
                
                alertViewController.preferredAction = confirmAction
            }
            catch {
                _logger.error("Unable to locate the top view controller")
                return
            }
        }
    }
    
    @MainActor
    func showAlertForSelectPhoto(onSelectCamera: @escaping () -> Void, onSelectGallery: @escaping () -> Void) {
        do {
            let topViewController = try UIApplication.shared.topController
            
            let alertViewController = UIAlertController(
                title: "Pick a photo",
                message: "Take a picture or use an existing one from your library",
                preferredStyle: .alert
            )
            
            topViewController.present(alertViewController, animated: true)
#if !targetEnvironment(simulator)
            alertViewController.addAction(
                .init(
                    title: "Take a photo",
                    style: .default,
                    handler: { _ in
                        onSelectCamera()
                    }
                )
            )
#endif
            alertViewController.addAction(
                .init(
                    title: "Select from gallery",
                    style: .default,
                    handler: { _ in
                        onSelectGallery()
                    }
                )
            )
            
            alertViewController.addAction(
                .init(
                    title: "Cancel",
                    style: .cancel,
                    handler: { _ in
                        alertViewController.dismiss(animated: true)
                    }
                )
            )
        }
        catch {
            _logger.error("Unable to locate the top view controller")
            return
        }
    }
}
