//
//  AccountsListCoordinator.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import UIKit
import Networking
import Foundation
import Coordinating
import SwiftUI

public protocol AccountsCoordinatorType: AnyObject, Coordinating {
    func displayErrorDialog(with message: String)
    func displayLogoutDialog(logoutRequested: @escaping () -> Void)
    func showProductDetail(
        product: ProductResponse,
        parentAccount: Account,
        moneyboxValueUpdated: @escaping () -> Void
    )
}

public class AccountsCoordinator: AccountsCoordinatorType {
    public var children: [Coordinating] = []
    public var router: Routing
    private let accountListDependencies: AccountsListDependenciesType
    private let productDetailDependencies: ProductDetailDependencies
    private let user: User
    
    public init(
        router: Routing,
        accountListDependencies: AccountsListDependenciesType,
        productDetailDependencies: ProductDetailDependencies,
        user: User
    ) {
        self.router = router
        self.accountListDependencies = accountListDependencies
        self.productDetailDependencies = productDetailDependencies
        self.user = user
    }
    
    public func start(isAnimated: Bool, canGoBack: Bool) {
        let viewModel = AccountsListViewModel(
            dependencies: accountListDependencies,
            coordinator: self,
            user: user
        )
        let viewController = AccountsListViewController(viewModel: viewModel)
        router.push(viewController, animated: isAnimated, canGoBack: canGoBack)
    }
    
    public func displayErrorDialog(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        router.present(alert, animated: true)
    }
    
    public func displayLogoutDialog(logoutRequested: @escaping () -> Void) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { _ in
            logoutRequested()
        })
        router.present(alert, animated: true)
    }
    
    public func showProductDetail(
        product: ProductResponse,
        parentAccount: Account,
        moneyboxValueUpdated: @escaping () -> Void
    ) {
        let viewModel = ProductDetailViewModel(
            dependencies: productDetailDependencies,
            coordinator: self,
            parentAccount: parentAccount,
            product: product,
            moneyboxValueUpdated: moneyboxValueUpdated
        )
        let viewController = ProductDetailViewController(viewModel: viewModel)
        router.push(viewController, animated: true, canGoBack: true)
    }
}
