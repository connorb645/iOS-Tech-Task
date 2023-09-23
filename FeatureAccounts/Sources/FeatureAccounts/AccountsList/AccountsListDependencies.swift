//
//  AccountsListDependencies.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import Networking
import Persistence

public struct AccountsListDependencies {
    public typealias ProductFetcher = ((@escaping (Result<AccountResponse, Error>) -> Void)) -> Void
    
    let sessionManager: SessionManager
    let logoutHandler: () -> Void
    let fetchProducts: ProductFetcher
    
    public init(
        sessionManager: SessionManager,
        logoutHandler: @escaping () -> Void,
        fetchProducts: @escaping ProductFetcher
    ) {
        self.sessionManager = sessionManager
        self.logoutHandler = logoutHandler
        self.fetchProducts = fetchProducts
    }
}
