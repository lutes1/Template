//
//  ToastView.swift
//  Template
//
//  Created by vadim josan on 09.02.2024.
//

import SwiftUI

struct ToastView: View {
    
    let image: UIImage
    let gradientColor: UIColor
    let title: String
    let message: String
    
    @State private var _width = DeviceType().isPad ? 425 : UIScreen.main.bounds.width - 36
   
    var body: some View {
            HStack(alignment: .center, spacing: 16) {
                Image(uiImage: image)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundStyle(.white)
                    
                    Text(message)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(
                width: _width,
                alignment: .leading
            )
            .background {
                    RadialGradient(
                        colors: [Color(gradientColor), .clear],
                        center: .leading,
                        startRadius: 0,
                        endRadius: 90
                    )
                    .blur(radius: 60)
                    .padding(.leading, 5)
            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    VStack {
        ToastView(image: UIImage(systemName: "checkmark.seal")!, gradientColor: .green, title: "Success", message: "Message")
        Spacer()
    }.background(.yellow)
}
