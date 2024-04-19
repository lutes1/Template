//
//  MoviesPageTests.swift
//  TemplateAppTests
//
//  Created by Petru Lutenco on 18.04.2024.
//

import XCTest
@testable import TemplateApp
import Core
import Domain
import ViewInspector
import SwiftUI

final class MoviesPageTests: XCTestCase {
    func test() throws {
        
        // Arrange
        let viewModel = MoviesViewModelMock()
        viewModel.mode = .discover
        
        let sut = MoviesPage(viewModel: viewModel)
        
        // Act
        try sut.inspect().view(MoviesPage.self).vStack().textField(0).setInput("Avengers")
        
        // Assert
        XCTAssertEqual(viewModel.query, "Avengers")
    }
}

fileprivate class MoviesViewModelMock: MoviesViewModelProtocol {
    var query: String = ""
    var mode: MoviesPageMode = .discover
    var pageState: PageState = .ready
    let title: String = "This is a mocked title!"
    
    func initialize(actions: MoviesPageActionsProtocol) { }
    
    var items: [Domain.Movie] = try! JSONDecoder.apiDateDecoder.decode([Movie].self, from: data.data(using: .utf8)!)
    
    var canLoadMoreItems: Bool = true
    
    func onMovieSelected(movie: Domain.Movie) { }
    
    func loadResultsPage() { }
    
    func imageUrl(for partialPath: String?) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/original/4QBDAZ8nBfZrplxMaxP7RoR6HXe.jpg")
    }
    
    private static let data =
    """
    [
        {
          "adult": false,
          "backdrop_path": "/ky4bep9wQPi225VRBnCySPz0sV.jpg",
          "genre_ids": [
            18,
            53,
            27
          ],
          "id": 682532,
          "original_language": "en",
          "original_title": "John and the Hole",
          "overview": "While exploring the neighboring woods, 13-year-old John discovers an unfinished bunker — a deep hole in the ground. Seemingly without provocation, he drugs his affluent parents and older sister and drags their unconscious bodies into the bunker, where he holds them captive. As they anxiously wait for John to free them from the hole, the boy returns home, where he can finally do what he wants.",
          "popularity": 19.609,
          "poster_path": "/vZ28AYbKm8cZdvnWlfCASOmH2ag.jpg",
          "release_date": "2021-08-06",
          "title": "John and the Hole",
          "video": false,
          "vote_average": 5.5,
          "vote_count": 108
        },
        {
          "adult": false,
          "backdrop_path": "/nZ0BF8X2dSb8XbI24aNQH6wNcTj.jpg",
          "genre_ids": [
            35,
            80
          ],
          "id": 38397,
          "original_language": "it",
          "original_title": "La leggenda di Al, John e Jack",
          "overview": "Hapless Depression-era gangsters Al, John and Jack discover their boss wants to get rid of them and come up with a plan to sell him to the FBI, but Al's short-term memory loss could be a problem...",
          "popularity": 7.882,
          "poster_path": "/t7Xb04P1uCUJ1LADWD5RfqWGyDu.jpg",
          "release_date": "2002-12-13",
          "title": "The Legend of Al, John and Jack",
          "video": false,
          "vote_average": 7.1,
          "vote_count": 1117
        }
    ]
    """
}
