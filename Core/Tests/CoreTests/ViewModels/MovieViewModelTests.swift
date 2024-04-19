//
//  CoreTests.swift
//  
//
//  Created by Petru Lutenco on 13.04.2024.
//

import XCTest
@testable import Core
import Domain
import os

final class CoreTests: XCTestCase {
    func test() async throws {
        
        // Arrange
        let sut = MoviesViewModel(
            moviesUseCase: MoviesUseCasesMock(),
            animationProvider: AnimationProviderMock(),
            analyticsService: AnalyticsServiceMock(),
            logger: Logger()
        )
        
        sut.initialize(actions: MoviesPageActionsMock())
        sut.mode = .discover
        
        // Act
        await sut.loadResultsPage()
        
        // Assert
        XCTAssertEqual(sut.items.count, 1)
        XCTAssertEqual(sut.canLoadMoreItems, true)
    }
}

fileprivate class MoviesPageActionsMock: MoviesPageActionsProtocol {
    nonisolated init() { }
    func showMovieDetails(movie: Domain.Movie) {
    }
}

fileprivate class MoviesUseCasesMock: MoviesUseCasesProtocol {
    func search(query: String, page: Int) async throws -> PaginatedResult<Domain.Movie> {
        try! JSONDecoder.apiDateDecoder.decode(PaginatedResult<Movie>.self, from: _dataJson.data(using: .utf8)!)
    }
    
    func discover(page: Int) async throws -> PaginatedResult<Domain.Movie> {
        try! JSONDecoder.apiDateDecoder.decode(PaginatedResult<Movie>.self, from: _dataJson.data(using: .utf8)!)
    }
    
    private var _dataJson: String {
        """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/lzWHmYdfeFiMIY4JaMmtR7GEli3.jpg",
              "genre_ids": [
                878,
                12
              ],
              "id": 438631,
              "original_language": "en",
              "original_title": "Dune",
              "overview": "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.",
              "popularity": 617.634,
              "poster_path": "/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
              "release_date": "2021-09-15",
              "title": "Dune",
              "video": false,
              "vote_average": 7.789,
              "vote_count": 11280
            }
          ],
          "total_pages": 43,
          "total_results": 842
        }
        """
    }
}
