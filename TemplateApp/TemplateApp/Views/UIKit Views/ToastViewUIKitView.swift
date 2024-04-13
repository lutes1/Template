//
//  ToastViewUIKitView.swift
//  Template
//
//  Created by vadim josan on 09.02.2024.
//

import SwiftUI
import UIKit

class ToastViewUIKitView: UIView {
    init(image: UIImage, gradientColor: UIColor, title: String, message: String) {
        super.init(frame: .zero)
        let cardView = UIHostingController(
            rootView: ToastView(image: image, gradientColor: gradientColor, title: title, message: message)
        )
        cardView.view.backgroundColor = .clear
        cardView.view.wrapIn(parent: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Nib initialization not supported")
    }
}
