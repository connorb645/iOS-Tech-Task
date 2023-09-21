//
//  AccountsListCoordinator.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import Coordinating

public final class AccountsListCoordinator: Coordinating {
    public var children: [Coordinating] = []
    public var router: Routing
    private let dependencies: AccountsListDependencies
    
    public init(router: Routing,
                dependencies: AccountsListDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    public func start(isAnimated: Bool, canGoBack: Bool) {
        let viewModel = AccountsListViewModel(dependencies: dependencies)
        let viewController = AccountsListViewController(viewModel: viewModel)
        router.push(viewController, animated: isAnimated, canGoBack: canGoBack)
    }
}
