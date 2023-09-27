//
//  AccountsListViewModel.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import Networking

final public class AccountsListViewModel {
    private let dependencies: AccountsListDependenciesType
    private let coordinator: AccountsCoordinatorType
    
    var response: AccountResponse?
    
    typealias AccountWithProducts = (account: Account, products: [ProductResponse])
    
    var accountProducts: [AccountWithProducts] {
        response?.accounts?.compactMap { account in
            return (account, products(for: account.wrapper?.id))
        } ?? []
    }
    
    var totalPlanValue: Double? {
        response?.totalPlanValue
    }
    
    var setIsFetchingProducts: ((Bool) -> Void)?
    var onProductsFetchComplete: (() -> Void)?
    
    var hasAccounts: Bool {
        let accountsEmpty = response?.accounts?.isEmpty ?? true
        return !accountsEmpty
    }
        
    public init(
        dependencies: AccountsListDependenciesType,
        coordinator: AccountsCoordinatorType
    ) {
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    // MARK: - Actions
    
    func fetchProducts() {
        setIsFetchingProducts?(true)
        
        dependencies.fetchProducts { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success(let response):
                    self.response = response
                case .failure(let error):
                    self.coordinator.displayErrorDialog(with: error.localizedDescription)
                }
                setIsFetchingProducts?(false)
                onProductsFetchComplete?()
            }
        }
    }
    
    func logout() {
        coordinator.displayLogoutDialog { [weak self] in
            guard let self else { return }
            dependencies.sessionManager.removeUserToken()
            dependencies.logoutHandler()
        }
    }
    
    func handleProductTapped(
        productId: Int,
        accountWrapperId: String,
        moneyboxValueUpdated: @escaping () -> Void
    ) {
        guard let product = accountProducts
            .flatMap({ $0.products })
            .first(where: { $0.id == productId }) else { return }
        
        guard let account = accountProducts
            .compactMap({ $0.account })
            .first(where: { $0.wrapper?.id == accountWrapperId }) else { return }
        
        coordinator.showProductDetail(
            product: product,
            parentAccount: account,
            moneyboxValueUpdated: moneyboxValueUpdated
        )
    }
    
    // MARK: - Utils
    
    func formatAsCurrency(_ amount: Double) -> String {
        dependencies.formatAsCurrency(amount)
    }
    
    private func products(for wrapperId: String?) -> [ProductResponse] {
        guard let wrapperId else { return [] }
        return response?.productResponses?
            .filter { wrapperId == $0.wrapperID } ?? []
    }
    
    private func account(for wrapperId: String?) -> Account? {
        response?.accounts?.first { $0.wrapper?.id == wrapperId }
    }
    
    private func product(for id: String?) -> ProductResponse? {
        guard let id else { return nil }
        return response?.productResponses?.first { $0.id == Int(id) }
    }
}
