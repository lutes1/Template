//
//  UrlLauncherProviderProtocol.swift
//
//
//  Created by Petru Lutenco on 01.02.2024.
//

import Foundation

public protocol UrlLauncherProviderProtocol {
    func launch(url: URL)
    
    func launch(urlString: String) throws

    func callPhoneNumber(phoneNumber: String) throws
    func openMailWith(addrress: String) throws
    
    func showAppInAppStore() throws
}
