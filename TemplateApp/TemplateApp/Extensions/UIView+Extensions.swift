//
//  UIView+Extensions.swift
//  Template
//
//  Created by Petru Lutenco on 17.11.2023.
//

import UIKit

extension UIView {
    func wrapIn(parent: UIView, consideringSafeArea: Bool = false, offset: CGFloat = 0) {
        parent.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: consideringSafeArea ? parent.safeAreaLayoutGuide.topAnchor : parent.topAnchor, constant: offset),
            self.leadingAnchor.constraint(equalTo: consideringSafeArea ? parent.safeAreaLayoutGuide.leadingAnchor : parent.leadingAnchor, constant: offset),
            self.trailingAnchor.constraint(equalTo: consideringSafeArea ? parent.safeAreaLayoutGuide.trailingAnchor : parent.trailingAnchor, constant: -offset),
            self.bottomAnchor.constraint(equalTo: consideringSafeArea ? parent.safeAreaLayoutGuide.bottomAnchor : parent.bottomAnchor, constant: -offset)
        ])
    }
}
