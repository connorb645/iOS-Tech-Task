//
//  AccountsListDependenciesMock.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import Core
import XCTest
import Foundation
import Networking
import SharedTestUtils
@testable import FeatureAccounts

final class AccountsListDependenciesMock: AccountsListDependenciesType {
    enum MethodCall: Equatable {
        case invokeLogoutHandler
        case invokeFetchProducts(Output<Result<AccountResponse, EquatableError>>)
        case invokeFormatAsCurrency(InputOutput<Double, String>)
    }
    
    let sessionManager: SessionManagerType
    
    var fetchProductsResult: Result<AccountResponse, Error>?
    lazy var fetchProducts: ProductFetcher = { [weak self] completion in
        guard let self else { return }
        guard let fetchProductsResult else {
            XCTFail("fetchProductsResult not set.")
            return
        }
        let equatableResult = fetchProductsResult.mapError({ EquatableError($0) })
        self.methodCalls.append(.invokeFetchProducts(.init(equatableResult)))
        completion(fetchProductsResult)
    }
    
    lazy var logoutHandler: (() -> Void) = { [weak self] in
        self?.methodCalls.append(.invokeLogoutHandler)
    }
    
    lazy var formatAsCurrency: CurrencyFormatter = { [weak self] amount in
        let result = Core.formatAsCurrency(amount: amount)
        self?.methodCalls.append(.invokeFormatAsCurrency(InputOutput(input: .init(amount), output: .init(result))))
        return result
    }
    
    var methodCalls: [MethodCall] = []
    
    init(sessionManager: SessionManagerMock = SessionManagerMock()) {
        self.sessionManager = sessionManager
    }}
