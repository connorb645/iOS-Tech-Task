//
//  LaunchCoordinator.swift
//  MoneyBox
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import Coordinating
import FeatureLogin
import FeatureAccounts

final class LaunchCoordinator: Coordinating {
    var children: [Coordinating] = []
    var router: Routing
    
    var dependencies: AppDependencies
    
    init(
        router: Routing,
        dependencies: AppDependencies
    ) {
        self.router = router
        self.dependencies = dependencies
    }
    
    func start(isAnimated: Bool, canGoBack: Bool) {
        let authToken = dependencies.authPersistence.getAuthToken()
        let coordinator: Coordinating
        if let authToken {
            coordinator = AccountsListCoordinator(
                router: router,
                dependencies: dependencies.accountsListDependencies
            )
            
        } else {
            coordinator = LoginCoordinator(
                router: router,
                dependencies: dependencies.loginDependencies
            )
        }
        children.append(coordinator)
        coordinator.start(isAnimated: false, canGoBack: canGoBack)
    }
}
