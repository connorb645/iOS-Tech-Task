//
//  SceneDelegate.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appBootstrap: AppBootstrap?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let navigationController = UINavigationController()
            self.appBootstrap = AppBootstrap(
                router: navigationController,
                window: window,
                windowScene: windowScene
            )
        }
    }
}
