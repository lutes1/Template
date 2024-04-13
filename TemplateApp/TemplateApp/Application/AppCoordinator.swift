//
//  AppCoordinator.swift
//  Template
//
//  Created by Petru Lutenco on 01.11.2023.
//

import Foundation
import UIKit
import Shared
import Core
import Domain
import SwiftUI
import os

@MainActor
class AppCoordinator: ApplicationCoordinatorProtocol {
    
    nonisolated init() { }
    
    private var _rootNavigationController: UINavigationController!
    
    func presentLoginScreen() {
        // Add login screen
    }
    
    func start() -> UINavigationController {
        _rootNavigationController = UINavigationController()
        
        let homeViewModel = DIContainer.shared.resolve(HomeViewModelProtocol.self)
        let homePageViewController = GenericSUIViewController(rootView: HomePageView(viewModel: homeViewModel))
        _rootNavigationController.setViewControllers([homePageViewController], animated: false)
        return _rootNavigationController
    }
    
    func showUpdateDialogue(model: AppUpdateDialogModel) {
        let view = AppUpdateDialog(model: model) { [weak self] in
            guard let self else { return }
            _rootNavigationController.dismiss(animated: true)
        }
        
        let vc = UIHostingController.init(rootView: view)
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        _rootNavigationController.present(vc, animated: true)
    }
}
