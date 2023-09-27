//
//  LoginCoordinator.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import Networking
import Coordinating

protocol LoginCoordinatorType: Coordinating, AnyObject {
    func handleSuccessfulLogin(user: LoginResponse.User)
}

public final class LoginCoordinator: LoginCoordinatorType {
    public var children: [Coordinating] = []
    public var router: Routing
    private let dependencies: LoginDependenciesType
    
    public init(router: Routing,
                dependencies: LoginDependenciesType) {
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
    
    public func handleSuccessfulLogin(user: LoginResponse.User) {
        dependencies.successfulLoginHandler(router, user)
    }
}
