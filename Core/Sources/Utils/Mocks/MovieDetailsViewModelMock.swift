//
//  MovieDetailsViewModelMock.swift
//  
//
//  Created by Petru Lutenco on 18.04.2024.
//

import Foundation
import Domain

class MovieDetailsViewModelMock: MovieDetailsViewModelProtocol {
    var movie: Movie! = {
        do {
            return try JSONDecoder.apiDateDecoder.decode(Movie.self, from: _movieJson.data(using: .utf8)!)
        } catch {
            print(error.localizedDescription)
            fatalError(error.localizedDescription)
        }
    }()
    
    func initialize(actions: MovieDetailsPageActionsProtocol, movie: Movie) {
    }
    
    func openFullResolutionImage(url: String) {
    }
    
    private static let _movieJson =
    """
    {
          "adult": false,
          "backdrop_path": "https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
          "genre_ids": [
            878,
            12
          ],
          "id": 693134,
          "original_language": "en",
          "original_title": "Dune: Part Two",
          "overview": "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.",
          "popularity": 2938.734,
          "poster_path": "https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
          "release_date": "2024-02-27",
          "title": "Dune: Part Two",
          "video": false,
          "vote_average": 8.299,
          "vote_count": 2962
    }
    """
}
