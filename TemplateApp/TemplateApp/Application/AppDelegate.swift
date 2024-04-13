//
//  AppDelegate.swift
//  Template
//
//  Created by Petru Lutenco on 30.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppSetup.setup()
        return true
    }
}
