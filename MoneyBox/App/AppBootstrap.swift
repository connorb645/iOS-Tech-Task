//
//  AppBootstrap.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import UIKit
import Foundation
import Networking
import Coordinating
import FeatureLogin
import FeatureAccounts
import Persistence
import Core

final class AppBootstrap {
    private var coordinator: Coordinating?
    private var router: Routing
    
    private let dataProvider: DataProviderLogic
    private let authPersistence: Auth
    
    private var window: UIWindow?
    private var windowScene: UIWindowScene?
    
    private lazy var accountsListDependencies: AccountsListDependencies = {
        AccountsListDependencies(
            authPersistence: authPersistence,
            logoutHandler: { [weak self] in
                guard let self else { return }
                if let windowScene {
                    let navigationController = UINavigationController()
                    self.router = navigationController
                    self.configureWindow(with: windowScene, router: navigationController)
                    self.startLaunchCoordinator()
                }
            }
        )
    }()
    
    private lazy var loginDependencies: LoginDependencies = {
        LoginDependencies(
            authPersistence: authPersistence,
            login: dataProvider.login(request:completion:),
            successfulLoginHandler: { [weak self] router in
                guard let self else { return }
                router.push(
                    AccountsListViewController(
                        viewModel: .init(
                            dependencies: accountsListDependencies
                        )
                    ),
                    animated: true,
                    canGoBack: false
                )
            },
            emailValidator: EmailValidator(),
            passwordValidator: PasswordValidator()
        )
    }()
    
    private lazy var appDependencies: AppDependencies = {
        AppDependencies(
            loginDependencies: loginDependencies,
            accountsListDependencies: accountsListDependencies,
            authPersistence: authPersistence
        )
    }()
    
    init(
        router: UINavigationController,
        window: UIWindow?,
        windowScene: UIWindowScene?
    ) {
        self.router = router
        self.window = window
        self.windowScene = windowScene
        
        let authPersistence = Auth.shared
        self.authPersistence = authPersistence
        
        let dataProvider = DataProvider()
        self.dataProvider = dataProvider
        
        if let windowScene {
            self.configureWindow(with: windowScene, router: router)
            self.startLaunchCoordinator()
        }
    }
    
    private func startLaunchCoordinator() {
        let coordinator = LaunchCoordinator(
            router: router,
            dependencies: appDependencies
        )
        self.coordinator = coordinator
        self.coordinator?.start(isAnimated: false, canGoBack: true)
    }
    
    private func configureWindow(
        with windowScene: UIWindowScene,
        router: UINavigationController
    ) {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = router
        window.makeKeyAndVisible()
        self.window = window
    }
}
