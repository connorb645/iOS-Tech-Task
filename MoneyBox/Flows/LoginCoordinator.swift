//
//  LoginCoordinator.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import Coordinating

final class LoginCoordinator: Coordinating {
    var children: [Coordinating] = []
    var router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        router.push(viewController, animated: false)
    }
}
