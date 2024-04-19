//
//  MoviesUseCases.swift
//
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation

public protocol MoviesUseCasesProtocol {
    func search(query: String, page: Int) async throws -> PaginatedResult<Movie>
    func discover(page: Int) async throws -> PaginatedResult<Movie>
}

class MoviesUseCases: MoviesUseCasesProtocol {
    
    private let _moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        _moviesRepository = moviesRepository
    }
    
    func search(query: String, page: Int) async throws -> PaginatedResult<Movie> {
        try await _moviesRepository.search(query: query, page: page)
    }
    
    func discover(page: Int) async throws -> PaginatedResult<Movie> {
        try await _moviesRepository.discover(page: page)
    }
}
