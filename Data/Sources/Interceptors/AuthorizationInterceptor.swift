//
//  AuthorizationInterceptor.swift
//  
//
//  Created by Petru Lutenco on 15.04.2024.
//

import Foundation
import Papyrus
import os

class AuthorizationInterceptor: Interceptor {
    
    private let _headerKey = "Authorization"
    
    private let _logger: Logger
    
    init(logger: Logger) {
        _logger = logger
    }
    
    func intercept(req: Request, next: (Request) async throws -> Response) async throws -> Response {
        var req = req
        
        if req.headers[_headerKey] != nil {
            let accessToken = try await _getAccessToken()
            req.headers[_headerKey] = "Bearer \(accessToken)"
        }
        
        return try await next(req)
    }
    
    private func _getAccessToken() async throws -> String {
       "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NjVhNGZiYzIzYWQwMzRiNjAxMzBjOTYzNDc4YTU4MyIsInN1YiI6IjY2MWQ1MzcxMGU1YWJhMDE0OWY0NzAxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dy5KQMco2heyPew1PE2FMzr2KlKiJU96JQuQK7Mh6Dk"
    }
}
