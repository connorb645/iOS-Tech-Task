//
//  ProductDetailDependencies.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Foundation
import Networking

public struct ProductDetailDependencies {
    public typealias OneOffPaymentRequester = (OneOffPaymentRequest, @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) -> Void
    
    let oneOffPaymentRequester: OneOffPaymentRequester
    
    public init(oneOffPaymentRequester: @escaping OneOffPaymentRequester) {
        self.oneOffPaymentRequester = oneOffPaymentRequester
    }
}
