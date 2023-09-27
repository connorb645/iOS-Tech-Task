//
//  AccountCoordinatorSpy.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import Foundation
import Networking
import Coordinating
import SharedTestUtils
@testable import FeatureAccounts

final class AccountsCoordinatorMock: AccountsCoordinatorType {
    struct ShowProductDetailInvocation: Equatable {
        let response: ProductResponse
        let account: Account
    }
    
    struct StartInvocation: Equatable {
        let isAnimated: Bool
        let canGoBack: Bool
    }
    
    enum MethodCall: Equatable {
        case displayErrorDialog(Input<String>)
        case showProductDetail(Input<ShowProductDetailInvocation>)
        case displayLogoutDialog
        case start(StartInvocation)
    }
    
    var children: [Coordinating] = []
    var router: Routing = RouterMock()
    var methodCalls: [MethodCall] = []
    
    func displayErrorDialog(with message: String) {
        methodCalls.append(.displayErrorDialog(.init(message)))
    }
    
    func showProductDetail(
        product: ProductResponse,
        parentAccount: Account,
        moneyboxValueUpdated: @escaping () -> Void
    ) {
        methodCalls.append(.showProductDetail(.init(.init(response: product, account: parentAccount))))
    }
    
    func displayLogoutDialog(logoutRequested: @escaping () -> Void) {
        methodCalls.append(.displayLogoutDialog)
    }
    
    func start(isAnimated: Bool, canGoBack: Bool) {
        methodCalls.append(.start(.init(isAnimated: isAnimated, canGoBack: canGoBack)))
    }
}

