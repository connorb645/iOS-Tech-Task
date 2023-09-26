//
//  ProductDetailDependencies.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Core
import Foundation
import Networking

public struct ProductDetailDependencies {
    public typealias OneOffPaymentRequester = (OneOffPaymentRequest, @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) -> Void
    
    let oneOffPaymentRequester: OneOffPaymentRequester
    let formatAsCurrency: CurrencyFormatter
    
    public init(
        oneOffPaymentRequester: @escaping OneOffPaymentRequester,
        formatAsCurrency: @escaping CurrencyFormatter
    ) {
        self.oneOffPaymentRequester = oneOffPaymentRequester
        self.formatAsCurrency = formatAsCurrency
    }
}
