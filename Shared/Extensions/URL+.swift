//
//  URL+.swift
//  Shared
//
//  Created by Petru Lutenco on 18.04.2024.
//

import Foundation

extension URL {
    init?(optionalString: String?) {
        guard let stringUrl = optionalString else {
            return nil
        }
        
        self.init(string: stringUrl)
    }
}
