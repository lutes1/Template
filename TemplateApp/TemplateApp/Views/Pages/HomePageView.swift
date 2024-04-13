//
//  HomePage.swift
//  Template
//
//  Created by Petru Lutenco on 11.04.2024.
//

import SwiftUI
import Core
import Shared

struct HomePageView: View {
    @State var viewModel: HomeViewModelProtocol
    
    var body: some View {
        Text(viewModel.title)
            .foregroundStyle(.white)
    }
}

#Preview {
    HomePageView(viewModel: DIContainer.shared.resolveMock(HomeViewModelProtocol.self))
}
