//
//  ExpandedModifier.swift
//  Template
//
//  Created by Petru Lutenco on 30.01.2024.
//

import SwiftUI

struct ExpandedModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    func expanded() -> some View {
        modifier(ExpandedModifier())
    }
}
