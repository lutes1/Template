//
//  ToastProvider.swift
//  Template
//
//  Created by vadim josan on 21.11.2023.
//

import Foundation
import Core
import UIKit
import os
import SwiftUI

class ToastProvider: ToastProviderProtocol {
    
    private var _logger: Logger
    
    init(logger: Logger) {
        _logger = logger
    }
    
    @MainActor
    func showToast(message: String) {
        showToast(image: UIImage(systemName: "checkmark.circle")!, gradientColor: .green, title: "Success!", message: message)
    }
    
    @MainActor
    func showError(message: String) {
        showToast(image: UIImage(systemName: "xmark.circle")!, gradientColor: .red, title: "Error!", message: message)
    }
    
    @MainActor
    func showWarning(message: String) {
        showToast(image: UIImage(systemName: "xmark.circle")!, gradientColor: .orange, title: "Warning!", message: message)
    }
    
    private func showToast(image: UIImage, gradientColor: UIColor, title: String, message: String) {
        let rootNavController = try? UIApplication.shared.rootController as? UINavigationController
        guard let topViewController = rootNavController?.topViewController else {
            _logger.error("TopViewController not found at show toast message")
            return
        }
        
        let view = ToastViewUIKitView(
            image: image,
            gradientColor: gradientColor,
            title: title,
            message: message
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        topViewController.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topViewController.view.topAnchor, constant: 26),
            view.centerXAnchor.constraint(equalTo: topViewController.view.centerXAnchor)
        ])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            view.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseIn, animations: {
                view.alpha = 0.0
            }, completion: {_ in
                view.removeFromSuperview()
            })
        })
    }
}
