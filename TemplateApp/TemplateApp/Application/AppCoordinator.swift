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
        
        let moviesViewModel = DIContainer.shared.resolve(MoviesViewModelProtocol.self)
        moviesViewModel.initialize(actions: self)
        let moviesViewController = GenericSUIViewController(
            rootView: MoviesPage(
                viewModel: moviesViewModel
            )
        )
        
        _rootNavigationController.setViewControllers([moviesViewController], animated: false)
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

extension AppCoordinator: MoviesPageActionsProtocol {
    func showMovieDetails(movie: Movie) {
        let movieDetailsViewModel = DIContainer.shared.resolve(MovieDetailsViewModelProtocol.self)
        movieDetailsViewModel.initialize(actions: self, movie: movie)
        let movieDetailsViewController = GenericSUIViewController(
            rootView: MovieDetails(
                viewModel: movieDetailsViewModel
            )
        )
        
        _rootNavigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension AppCoordinator: MovieDetailsPageActionsProtocol {
    func openFullResolutionImage(url: String) {
        let movieDetailsViewController = GenericSUIViewController(
            rootView: MoviePosterViewerPage(posterPath: url)
        )
        
        _rootNavigationController.present(movieDetailsViewController, animated: true)
    }
}
