//
//  NetworkErrorDecodingService.swift
//  Data
//
//  Created by vadim josan on 05.12.2023.
//

import Foundation
import PapyrusCore
import Domain

protocol NetworkErrorDecodingServiceProtocol {
    func decode(_ error: Error) throws -> NetworkError
}

class NetworkErrorDecodingService: NetworkErrorDecodingServiceProtocol {
    
    func decode(_ error: Error) throws -> NetworkError {
        if let papyrusError = error as? PapyrusError {
            guard let data = papyrusError.response?.body else {
                throw NSError(domain: "Network error has no body", code: 1)
            }
            
            let decoder = JSONDecoder()
            var apiError = try decoder.decode(NetworkError.self, from: data)
            
            let headers = papyrusError.request?.headers.reduce(into: "") { result, next in
                result = result + "[\(next.key): \(next.value)]"
            }
            
            let metadata = NetworkErrorMetadata(
                requestUrl: papyrusError.request?.url?.absoluteString,
                body: papyrusError.request?.body?.base64EncodedString(),
                queryParams: headers
            )
            
            apiError.metadata = metadata
            
            return apiError
        }
        
        throw error
    }
}
