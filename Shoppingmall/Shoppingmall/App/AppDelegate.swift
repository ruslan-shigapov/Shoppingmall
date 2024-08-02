//
//  AppDelegate.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 02.08.2024.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any
        ]?
    ) -> Bool {
        NetworkManager.shared.setupMobileDeviceId()
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window else { return false }
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        return true
    }
}

