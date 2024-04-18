//
//  DomainRegisterer.swift
//  Template.Domain
//
//  Created by Petru Lutenco on 06.11.2023.
//

import Foundation
import Shared
import PublicInitialiserMacro

@PublicInitialiser
public class DomainSetup : RegistererProtocol {
    public func setup(with container: DIContainer) {
        DIContainer.shared.register(AppUpdateUseCaseProtocol.self, with: AppUpdateUseCase.init, scope: .singleton)
        DIContainer.shared.register(MoviesUseCasesProtocol.self, with: MoviesUseCases.init, scope: .singleton)
    }
}
