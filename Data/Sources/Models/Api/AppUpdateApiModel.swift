//
//  AppUpdateApiModel.swift
//  
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation

struct AppUpdateApiModel: Decodable {
    let hasNewVersion: Bool
    let shouldForceUpdate: Bool
}
