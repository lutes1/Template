//
//  UserDefaults+Codable.swift
//  Data
//
//  Created by Petru Lutenco on 29.11.2023.
//

import Foundation

extension UserDefaults {
    func setCodable<Element: Codable>(_ value: Element, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        setValue(data, forKey: key)
    }
    
    func getCodable<Element: Codable>(forKey key: String) throws -> Element {
        guard let data = data(forKey: key) else {
            throw UserDefaultsErrors.noValueWasFoundForKey(key)
        }
        
        let element = try JSONDecoder().decode(Element.self, from: data)
        return element
    }
}
