//
//  AccountsListViewModel.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation

public struct AccountsListViewModel {
    private let dependencies: AccountsListDependencies
    
    public init(dependencies: AccountsListDependencies) {
        self.dependencies = dependencies
    }
    
    func logout() {
        dependencies.authPersistence.clearAuthToken()
        dependencies.logoutHandler()
    }
}
