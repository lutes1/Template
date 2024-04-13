//
//  ViewModel.swift
//  
//
//  Created by Petru Lutenco on 30.01.2024.
//

import Foundation
import Shared
import os

public protocol ViewModelProtocol {
    var pageState: PageState { get }
}

@Observable
class ViewModel: ViewModelProtocol {
    let animationProvider: AnimationProviderProtocol
    let analyticsService: AnalyticsServiceProtocol
    let logger: Logger
    
    var pageState: PageState = .ready
    
    init(
        animationProvider: AnimationProviderProtocol,
        analyticsService: AnalyticsServiceProtocol,
        logger: Logger
    ) {
        self.animationProvider = animationProvider
        self.logger = logger
        self.analyticsService = analyticsService
    }
}
