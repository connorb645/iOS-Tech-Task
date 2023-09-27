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
import Core
import CoreUI

final class AppBootstrap {
    private let theme: ThemeProvider
    private var router: Routing
    
    private let dataProvider: DataProviderLogic
    private let sessionManager: SessionManagerType
    
    private var window: UIWindow?
    private var windowScene: UIWindowScene?
    
    private lazy var accountsListDependencies: AccountsListDependencies = {
        AccountsListDependencies(
            sessionManager: sessionManager,
            logoutHandler: { [weak self] in
                guard let self else { return }
                if let windowScene {
                    let navigationController = UINavigationController()
                    self.router = navigationController
                    self.configureWindow(with: windowScene, router: navigationController)
                    self.startLaunchCoordinator()
                }
            },
            fetchProducts: dataProvider.fetchProducts(completion:),
            formatAsCurrency: { amount in
                formatAsCurrency(amount: amount)
            },
            theme: self.theme
        )
    }()
    
    private lazy var productDetailDependencies: ProductDetailDependencies = {
        ProductDetailDependencies(
            oneOffPaymentRequester: dataProvider.addMoney(request:completion:),
            formatAsCurrency: { amount in
                formatAsCurrency(amount: amount)
            },
            theme: self.theme
        )
    }()
    
    private var accountsCoordinator: AccountsCoordinator {
        .init(
            router: router,
            accountListDependencies: accountsListDependencies,
            productDetailDependencies: productDetailDependencies
        )
    }
    
    private lazy var loginDependencies: LoginDependenciesType = {
        LoginDependencies(
            sessionManager: SessionManager(),
            login: dataProvider.login(request:completion:),
            successfulLoginHandler: { [weak self] router in
                guard let self else { return }
                router.push(
                    AccountsListViewController(
                        viewModel: .init(
                            dependencies: accountsListDependencies,
                            coordinator: accountsCoordinator
                        )
                    ),
                    animated: true,
                    canGoBack: false
                )
            },
            emailValidator: EmailValidator(),
            passwordValidator: PasswordValidator(),
            theme: self.theme,
            bundle: .main
        )
    }()
    
    private lazy var appDependencies: AppDependencies = {
        AppDependencies(
            loginDependencies: loginDependencies,
            accountsListDependencies: accountsListDependencies
        )
    }()
    
    init(
        router: UINavigationController,
        window: UIWindow?,
        windowScene: UIWindowScene?
    ) {
        self.theme = DefaultTheme(bundle: .main)
        self.router = router
        self.window = window
        self.windowScene = windowScene
        self.sessionManager = SessionManager()
        self.dataProvider = DataProvider()
        
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
        coordinator.start(isAnimated: false, canGoBack: true)
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
