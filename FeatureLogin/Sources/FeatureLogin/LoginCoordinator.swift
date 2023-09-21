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
    
    public init(router: Routing) {
        self.router = router
    }
    
    public func start() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        router.push(viewController, animated: false)
    }
}
