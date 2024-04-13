//
//  SceneDelegate.swift
//  Template
//
//  Created by Petru Lutenco on 30.10.2023.
//

import UIKit
import Core
import Domain
import Data
import Shared

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var _appCoordinator: AppCoordinator!
    private var _wasAppVersionChecked: Bool = false
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = _initialiseRootController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func _initialiseRootController() -> UIViewController {
        _appCoordinator = DIContainer.shared.resolve(AppCoordinator.self)
        return _appCoordinator.start()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        guard !_wasAppVersionChecked else {
            return
        }
        
        let appVersionUseCase = DIContainer.shared.resolve(AppUpdateUseCaseProtocol.self)
        appVersionUseCase.checkAppVersion(appCoordinator: _appCoordinator)
        
        _wasAppVersionChecked = true
    }
}
