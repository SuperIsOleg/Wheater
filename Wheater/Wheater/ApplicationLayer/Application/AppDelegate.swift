//
//  AppDelegate.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 17.06.23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

internal var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = WheaterViewController(viewModel: WheaterViewModel())
        return true
    }

}

