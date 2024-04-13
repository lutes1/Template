//
//  UrlLauncherProvider.swift
//  Template
//
//  Created by Petru Lutenco on 01.02.2024.
//

import Foundation
import UIKit
import Core
import Domain

class UrlLauncherProvider : UrlLauncherProviderProtocol {
    func callPhoneNumber(phoneNumber: String) throws {
        try launch(urlString: "tel:\(phoneNumber)")
    }
    
    func openMailWith(addrress: String) throws {
        try launch(urlString: "mailto:\(addrress)")
    }
    
    func launch(urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Unable to create an URL from the provided string: \(urlString) ", code: 0)
        }
        
        launch(url: url)
    }
    
    func launch(url: URL) {
        UIApplication.shared.open(url)
    }
    
    func showAppInAppStore() throws {
        try launch(urlString: "_app_store_link_")
    }
}
