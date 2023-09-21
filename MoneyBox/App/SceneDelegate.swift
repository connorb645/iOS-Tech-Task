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
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let appBootstrap = AppBootstrap()
            window = appBootstrap.configureWindow(with: windowScene)
        }
    }
}
