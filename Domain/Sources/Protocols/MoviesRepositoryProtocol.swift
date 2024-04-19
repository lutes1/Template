//
//  MoviesRepositoryProtocol.swift
//  
//
//  Created by Petru Lutenco on 18.04.2024.
//

import Foundation

public protocol MoviesRepositoryProtocol {
    func search(query: String, page: Int) async throws -> PaginatedResult<Movie>
    func discover(page: Int) async throws -> PaginatedResult<Movie>
}
