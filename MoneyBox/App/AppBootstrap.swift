//
//  AppBootstrap.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import UIKit
import Coordinating
import FeatureLogin

final class AppBootstrap {
    private var rootNavigationController: UINavigationController
    private var rootCoordinator: Coordinating
    
    init() {
        self.rootNavigationController = UINavigationController()
        self.rootCoordinator = LoginCoordinator(router: rootNavigationController)
        rootCoordinator.start()
    }
    
    func configureWindow(with windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        return window
    }
}
