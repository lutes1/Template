//
//  MovieDetailsViewModel.swift
//
//
//  Created by Petru Lutenco on 18.04.2024.
//

import Foundation
import Domain

public protocol MovieDetailsPageActionsProtocol {
    func openFullResolutionImage(url: String)
}

public protocol MovieDetailsViewModelProtocol {
    var movie: Movie! { get }
    
    func initialize(actions: MovieDetailsPageActionsProtocol, movie: Movie)
    func openFullResolutionImage(url: String)
}

class MovieDetailsViewModel: ViewModel, MovieDetailsViewModelProtocol {
    
    private var _actions: MovieDetailsPageActionsProtocol!
    
    var movie: Movie!
    
    func initialize(actions: MovieDetailsPageActionsProtocol, movie: Movie) {
        _actions = actions
        self.movie = movie
    }
    
    func openFullResolutionImage(url: String) {
        _actions.openFullResolutionImage(url: url)
    }
}
