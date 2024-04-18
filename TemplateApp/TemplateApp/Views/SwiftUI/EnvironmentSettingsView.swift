//
//  EnvironmentSettingsView.swift
//  Template
//
//  Created by vadim josan on 22.11.2023.
//

import SwiftUI
import Core
import Shared

struct EnvironmentSettingsView: View {
    var viewModel: EnvironmentSettingsViewModelProtocol
    
    var body: some View {
        VStack{
            ZStack {
                Text("Environment Settings")
                
                HStack {
                    Spacer()
                    
                    Button(
                        "Done",
                        action: viewModel.done
                    )
                    .padding(.trailing, 20)
                }
            }
            .padding(.top, 20)
            
            List(viewModel.allEnvironments, id: \.name) { env in
                HStack {
                    Text(env.name)
                    
                    if viewModel.isSelected(env: env) {
                        Image(systemName: "check.circle")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.select(env)
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    EnvironmentSettingsView(viewModel: DIContainer.shared.resolveMock(EnvironmentSettingsViewModelProtocol.self))
}
