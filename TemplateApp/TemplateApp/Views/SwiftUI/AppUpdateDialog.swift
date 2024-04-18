//
//  UpdateDialog.swift
//  Template
//
//  Created by Petru Lutenco on 27.03.2024.
//

import SwiftUI
import Domain

struct AppUpdateDialog: View {
    
    let model: AppUpdateDialogModel
    let dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            
            VStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text(model.title)
                        .fontWeight(.semibold)
                    
                    Text(model.message)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxHeight: .infinity)
                
                Rectangle()
                    .frame(height: 1)
                
                HStack(spacing: 0) {
                    if !model.isForceUpdate {
                        Button {
                            dismissAction()
                        } label: {
                            Color.clear.overlay {
                                Text("Later")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Rectangle()
                            .frame(width: 1)
                    }
                    
                    Button {
                        model.confirmAction()
                        
                        if !model.isForceUpdate {
                            dismissAction()
                        }
                    } label: {
                        Color.clear.overlay {
                            Text("Update Now")
                        }
                    }
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 44)
            }
            .frame(width: 270, height: 156)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AppUpdateDialog(
        model: .init(
            title: "Update Available",
            message: "We’ve lunched a new and improved version of the app. Would you like to update it now?",
            confirmAction: { },
            isForceUpdate: true
        ),
        dismissAction: { }
    )
}
