//
//  ProductDetailDependenciesMock.swift
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

final class ProductDetailDependenciesMock: ProductDetailDependenciesType {
    enum MethodCall: Equatable {
        case invokeOneOffPaymentRequest(InputOutput<OneOffPaymentRequest, Result<OneOffPaymentResponse, EquatableError>>)
        case invokeFormatAsCurrency(InputOutput<Double, String>)
    }
    
    var oneOffPaymentResult: Result<OneOffPaymentResponse, Error>?
    lazy var oneOffPaymentRequester: OneOffPaymentRequester = { [weak self] request, completion in
        guard let self else { return }
        guard let oneOffPaymentResult else {
            XCTFail("oneOffPaymentResult not set.")
            return
        }
        let equatableResult = oneOffPaymentResult.mapError { EquatableError($0) }
        self.methodCalls.append(.invokeOneOffPaymentRequest(.init(input: .init(request), output: .init(equatableResult))))
        completion(oneOffPaymentResult)
    }

    lazy var formatAsCurrency: CurrencyFormatter = { [weak self] amount in
        let result = Core.formatAsCurrency(amount: amount)
        self?.methodCalls.append(.invokeFormatAsCurrency(InputOutput(input: .init(amount), output: .init(result))))
        return result
    }
    
    var methodCalls: [MethodCall] = []
}
