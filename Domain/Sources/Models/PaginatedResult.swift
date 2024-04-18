//
//  File.swift
//  
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation
public typealias Item = Equatable&Decodable

public struct PaginatedResult<T: Item>: Equatable, Decodable {
    public let page: Int
    public let totalPages: Int
    public let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}
