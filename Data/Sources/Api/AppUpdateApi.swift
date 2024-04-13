//
//  AppUpdateApiProtocol.swift
//
//
//  Created by Petru Lutenco on 27.03.2024.
//

import Foundation
import Papyrus
import Domain

@API()
protocol AppUpdateApiProtocol {
    
    @GET("utils/app-version")
    func checkAppVersion(appVersion: Query<String>) async throws -> AppUpdateApiModel
}
