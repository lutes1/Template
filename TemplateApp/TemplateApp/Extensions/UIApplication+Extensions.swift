//
//  UIApplication+Extensions.swift
//  Template
//
//  Created by Petru Lutenco on 17.11.2023.
//

import UIKit

extension UIApplication {
    var rootController: UIViewController {
        get throws {
            let rootViewController: UIViewController? = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .filter { $0.activationState == .foregroundActive }
                .first?
                .keyWindow?
                .rootViewController
            
            guard let rootViewController else {
                throw UIApplicationErrors.invalidRootViewController
            }
            
            return rootViewController
        }
    }
    
    var topController: UIViewController {
        get throws {
            let rootNavController = try UIApplication.shared.rootController as! UINavigationController
            guard var topViewController = rootNavController.topViewController else {
                throw UIApplicationErrors.invalidRootViewController
            }
            
            if let presentingViewController = topViewController.presentedViewController {
                topViewController = presentingViewController
            }
            
            return topViewController
        }
    }
}

extension UINavigationController {
    var topController: UIViewController? {
        get {
            if let presentingViewController = topViewController?.presentedViewController {
                return presentingViewController
            }

            if let topViewController = topViewController {
                return topViewController
            }
            
            return nil
        }
    }
}
