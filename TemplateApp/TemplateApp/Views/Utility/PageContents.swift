//
//  PageContents.swift
//  Template
//
//  Created by Petru Lutenco on 30.01.2024.
//

import SwiftUI
import Core

struct PageContents<TContent: View>: View {
    @State private var _isPad = DeviceType().isPad
    
    let pageState: PageState
    var bgColor: Color = .clear
    var cornerRadius: CGFloat = 0
    
    @ViewBuilder
    let builder: () -> TContent
    
    var onRefresh: (() -> Void)? = nil
    
    var body: some View {
        switch pageState {
        case .ready:
            builder()
        case .loading:
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(bgColor)
                .overlay {
                    ProgressView()
                }
                .expanded()
                
        case .error(let error):
                RoundedRectangle(cornerRadius: cornerRadius)
                .fill(bgColor)
                .overlay {
                    HStack {
                        if onRefresh != nil {
                            Button {
                                onRefresh?()
                            } label: {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                        
                        Text(error)
                            .multilineTextAlignment(.center)
                            .lineLimit(5)
                    }
                    .padding(.horizontal, _isPad ? 0 : 20)
                }
                .expanded()
        }
    }
}
