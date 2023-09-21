//
//  LoginCoordinator.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import Coordinating

public final class LoginCoordinator: Coordinating {
    public var children: [Coordinating] = []
    public var router: Routing
    private let dependencies: LoginDependencies
    
    public init(router: Routing,
                dependencies: LoginDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    public func start(isAnimated: Bool, canGoBack: Bool) {
        let viewModel = LoginViewModel(
            dependencies: dependencies,
            coordinator: self
        )
        let viewController = LoginViewController(viewModel: viewModel)
        router.push(viewController, animated: isAnimated, canGoBack: canGoBack)
    }
    
    public func handleSuccessfulLogin() {
        dependencies.successfulLoginHandler(router)
    }
}
