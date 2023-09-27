//
//  AccountsListDependencies.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Core
import Foundation
import Networking

public typealias ProductFetcher = ((@escaping (Result<AccountResponse, Error>) -> Void)) -> Void

public protocol AccountsListDependenciesType {
    var sessionManager: SessionManagerType { get }
    var logoutHandler: () -> Void { get }
    var fetchProducts: ProductFetcher { get }
    var formatAsCurrency: CurrencyFormatter { get }
}

public struct AccountsListDependencies: AccountsListDependenciesType {
    public let sessionManager: SessionManagerType
    public let logoutHandler: () -> Void
    public let fetchProducts: ProductFetcher
    public let formatAsCurrency: CurrencyFormatter
    
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
