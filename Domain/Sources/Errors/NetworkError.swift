//
//  NetworkError.swift
//  Domain
//
//  Created by vadim josan on 05.12.2023.
//

import Foundation

public struct NetworkError: Error, Decodable, CustomStringConvertible {
    public let errorCode: Int
    public let message: String
    public var metadata: NetworkErrorMetadata?
    
    public var description: String {
        """
        errorCode: \(errorCode),
        message: \(message),
        url: \(metadata?.requestUrl ?? "unavailable")
        \nqueryParams: \(metadata?.queryParams ?? "none")
        \nbody: \(metadata?.body ?? "none")
        """
    }
}

public struct NetworkErrorMetadata: Decodable {
    public init(
        requestUrl: String?,
        body: String? = nil,
        queryParams: String? = nil
    ) {
        self.requestUrl = requestUrl
        self.body = body
        self.queryParams = queryParams
    }
    
    public let requestUrl: String?
    public let body: String?
    public let queryParams: String?
}
