//
//  Movie.swift
//  
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation

public struct Movie: Equatable, Identifiable, Decodable {
    
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let overview: String
    public let releaseDate: Date?
    public let popularity: Double
    public let voteAverage: Double
    public let voteCount: Int

    public init(id: Int, title: String, posterPath: String?, overview: String, releaseDate: Date?, popularity: Double, voteAverage: Double, voteCount: Int) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try? container.decode(Date.self, forKey: .releaseDate)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}

public enum Genre: Decodable {
    case adventure
    case scienceFiction
}
