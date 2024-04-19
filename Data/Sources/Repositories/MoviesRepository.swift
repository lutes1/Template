//
//  MoviesRepository.swift
//  
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation
import Domain

class MoviesRepository: MoviesRepositoryProtocol {
    private let _moviesApi: MoviesApiProtocol
    
    init(moviesApi: MoviesApiProtocol) {
        _moviesApi = moviesApi
    }
    
    func search(query: String, page: Int) async throws -> PaginatedResult<Movie> {
        try await _moviesApi.search(query: query, page: page, includeAdult: false)
    }
    
    func discover(page: Int) async throws -> PaginatedResult<Movie> {
        try await _moviesApi.discover(page: page, includeAdult: false)
    }
}
