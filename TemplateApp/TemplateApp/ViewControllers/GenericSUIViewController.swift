//
//  GenericSUIViewController.swift
//  Template
//
//  Created by vadim josan on 19.03.2024.
//

import UIKit
import SwiftUI

extension UIEdgeInsets {
    static let tabbarAndTrailing = UIEdgeInsets(top: 0, left: 116, bottom: 0, right: 20)
    static let tabbarAndVertical = UIEdgeInsets(top: 20, left: 116, bottom: 20, right: 20)
    static let twenty = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
}

class GenericSUIViewController<Content: View>: UIViewController {
    
    var rootView: Content
    private var _hostingController: UIHostingController<Content>
    private var _insets: UIEdgeInsets
    
    init(rootView: Content, insets: UIEdgeInsets = .zero) {
        self.rootView = rootView
        _hostingController = UIHostingController(rootView: rootView)
        _insets = insets
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _hostingController.view.backgroundColor = .white
        
        addChild(_hostingController)
        view.addSubview(_hostingController.view)
        
        _hostingController.didMove(toParent: self)
        
        _hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _hostingController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: _insets.top),
            _hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: _insets.left),
            _hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -_insets.right),
            _hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -_insets.bottom)
        ])
    }
    
    public func setSafeAreaRegions(_ safeAreaRegions: SafeAreaRegions) {
        _hostingController.safeAreaRegions = safeAreaRegions
    }
}
