//
//  MoviesViewModel.swift
//
//
//  Created by Petru Lutenco on 11.04.2024.
//

import Foundation
import Domain
import Shared
import os

@MainActor
public protocol MoviesPageActionsProtocol {
    func showMovieDetails(movie: Movie)
}

public protocol MoviesViewModelProtocol: ViewModelProtocol {
    var query: String { get set }
    var items: [Movie] { get }
    var canLoadMoreItems: Bool { get }
    
    func initialize(actions: MoviesPageActionsProtocol)
    func onMovieSelected(movie: Movie)
    func loadResultsPage() async
    var mode: MoviesPageMode { get set }
}

@Observable
class MoviesViewModel: ViewModel, MoviesViewModelProtocol {

    private let _moviesUseCase: MoviesUseCasesProtocol
    private var _actions: MoviesPageActionsProtocol!
    
    @ObservationIgnored
    private var _nextPage = 1
    
    @ObservationIgnored
    private var _loadingTask: Task<Void, Never>?

    var mode: MoviesPageMode = .discover
    
    var items: [Movie] = []
    
    var canLoadMoreItems: Bool = true

    var query: String = "" {
        didSet {
            if query != oldValue {
                _triggerSearch()
            }
        }
    }
    
    init(
        moviesUseCase: MoviesUseCasesProtocol,
        animationProvider: AnimationProviderProtocol,
        analyticsService: AnalyticsServiceProtocol,
        logger: Logger
    ) {
        _moviesUseCase = moviesUseCase
        
        super.init(
            animationProvider: animationProvider,
            analyticsService: analyticsService,
            logger: logger
        )
        
        pageState = .loading
    }
    
    func initialize(actions: MoviesPageActionsProtocol) {
        _actions = actions
    }
    
    @MainActor
    func onMovieSelected(movie: Movie) {
        _actions.showMovieDetails(movie: movie)
    }

    func loadResultsPage() async {
        do {
            try Task.checkCancellation()
            
            let newPage = try await _fetchData()
            
            try Task.checkCancellation()
            
            _nextPage += 1
            canLoadMoreItems = _nextPage < newPage.totalPages
            
            try await MainActor.run {
                try Task.checkCancellation()
                
                let moviesWithCompletePosterUrl = newPage.results.map {
                    $0.cloneWith(imageUrl: _imageUrl(for: $0.posterPath))
                }
                
                items.append(contentsOf: moviesWithCompletePosterUrl)
                pageState = .ready
            }
        } catch {
            if !Task.isCancelled {
                analyticsService.track(error, message: "Unable to load movies due to an error \(error)")
                pageState = .error("Unable to load movies due to an unknown error, please try again...")
            }
        }
    }
    
    private func _imageUrl(for partialPath: String?) -> String? {
        guard let partialPath else {
            return nil
        }
        
        let imagesUrl = "https://image.tmdb.org/t/p/original"
        return "\(imagesUrl)\(partialPath)"
    }
    
    private func _fetchData() async throws -> PaginatedResult<Movie> {
        switch mode {
        case .discover:
            try await _moviesUseCase.discover(page: _nextPage)
        case .search:
            try await  _moviesUseCase.search(query: _query, page: _nextPage)
        }
    }
    
    private func _triggerSearch() {
        _clean()
        
        _loadingTask = Task {
            do {
                try await Task.sleep(for: .seconds(0.5))
                
                await loadResultsPage()
            } catch { 
                // Task was cancelled
            }
        }
    }
    
    private func _clean() {
        pageState = .loading
        _loadingTask?.cancel()
        _nextPage = 1
        items = []
    }
}

fileprivate extension Movie {
    func cloneWith(imageUrl: String?) -> Movie {
        .init(
            id: id,
            title: title,
            posterPath: imageUrl,
            overview: overview,
            releaseDate: releaseDate,
            popularity: popularity,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
    }
}
