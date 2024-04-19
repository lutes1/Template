//
//  MoviesApiProtocol.swift
//  
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation
import Papyrus
import Domain

@API()
@JSON(decoder: JSONDecoder.apiDateDecoder)
@Authorization(.bearer)
protocol MoviesApiProtocol {
    
    @GET("/search/movie")
    func search(query: Query<String>, page: Query<Int>, includeAdult: Bool) async throws -> PaginatedResult<Movie>
    
    @GET("/discover/movie")
    func discover(page: Query<Int>, includeAdult: Bool) async throws -> PaginatedResult<Movie>
}
