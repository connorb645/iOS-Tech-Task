//
//  AccountsListDependencies.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Core
import Foundation
import Networking

public struct AccountsListDependencies {
    public typealias ProductFetcher = ((@escaping (Result<AccountResponse, Error>) -> Void)) -> Void
    
    let sessionManager: SessionManagerType
    let logoutHandler: () -> Void
    let fetchProducts: ProductFetcher
    let formatAsCurrency: CurrencyFormatter
    
    public init(
        sessionManager: SessionManagerType,
        logoutHandler: @escaping () -> Void,
        fetchProducts: @escaping ProductFetcher,
        formatAsCurrency: @escaping CurrencyFormatter
    ) {
        self.sessionManager = sessionManager
        self.logoutHandler = logoutHandler
        self.fetchProducts = fetchProducts
        self.formatAsCurrency = formatAsCurrency
    }
}
