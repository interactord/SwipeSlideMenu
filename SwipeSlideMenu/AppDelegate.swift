//
//  AppDelegate.swift
//  SwipeSlideMenu
//
//  Created by SANGBONG MOON on 17/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()

        let containter = HomeContainer()
//        let viewController = containter.getViewController()
//        window?.rootViewController = UINavigationController(rootViewController: viewController)

        let viewController = containter.getBaseViewController()
        window?.rootViewController = viewController
        return true
    }

}
