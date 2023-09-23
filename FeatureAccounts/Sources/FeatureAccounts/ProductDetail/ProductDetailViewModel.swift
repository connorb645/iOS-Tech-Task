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
    private let product: ProductResponse
    
    lazy var title: String = {
        product.product?.name ?? ""
    }()
        
    public init(
        dependencies: ProductDetailDependencies,
        coordinator: AccountsCoordinator,
        product: ProductResponse
    ) {
        self.dependencies = dependencies
        self.coordinator = coordinator
        self.product = product
    }
    
    func addOneOffPayment(of amount: Int) {
        guard let productId = product.id else { return }
        
        let request = OneOffPaymentRequest(
            amount: amount,
            investorProductID: productId
        )
        
        dependencies.oneOffPaymentRequester(request) { response in
            switch response {
            case .success(let result):
                print("Result received: \(result.moneybox ?? 0.0)")
            case .failure(let error):
                print("Error received: \(error)")
                
            }
        }
    }
}
