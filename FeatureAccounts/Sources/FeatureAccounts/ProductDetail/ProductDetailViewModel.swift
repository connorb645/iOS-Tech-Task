//
//  ProductDetailViewModel.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Foundation
import Networking

final public class ProductDetailViewModel {
    private let dependencies: ProductDetailDependencies
    private let coordinator: AccountsCoordinator
    private let parentAccount: Account
    private let product: ProductResponse
    
    lazy var productTitle: String = {
        product.product?.name ?? ""
    }()
    
    lazy var accountTitle: String = {
        parentAccount.name ?? ""
    }()
    
    let topUpAmount = 10
    
    var moneyboxValue: Double {
        product.moneybox ?? 0.0
    }
    
    var planValue: Double {
        product.planValue ?? 0.0
    }
    
    var setIsLoading: ((Bool) -> Void)?
    var newMoneyboxValueReceived: ((Double?) -> Void)?
    
    private var moneyboxValueUpdated: () -> Void
        
    public init(
        dependencies: ProductDetailDependencies,
        coordinator: AccountsCoordinator,
        parentAccount: Account,
        product: ProductResponse,
        moneyboxValueUpdated: @escaping () -> Void
    ) {
        self.dependencies = dependencies
        self.coordinator = coordinator
        self.parentAccount = parentAccount
        self.product = product
        self.moneyboxValueUpdated = moneyboxValueUpdated
    }
    
    func addOneOffPayment(of amount: Int) {
        guard let productId = product.id else { return }
        
        let request = OneOffPaymentRequest(
            amount: amount,
            investorProductID: productId
        )
        setIsLoading?(true)
        dependencies.oneOffPaymentRequester(request) { response in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch response {
                case .success(let result):
                    newMoneyboxValueReceived?(result.moneybox)
                    moneyboxValueUpdated()
                case .failure(let error):
                    coordinator.displayErrorDialog(with: error.localizedDescription)
                }
                setIsLoading?(false)
            }
        }
    }
    
    func formatAsCurrency(_ amount: Double) -> String {
        dependencies.formatAsCurrency(amount)
    }
}
