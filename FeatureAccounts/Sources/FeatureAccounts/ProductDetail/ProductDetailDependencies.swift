//
//  ProductDetailDependencies.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Core
import Foundation
import Networking
import CoreUI

public typealias OneOffPaymentRequester = (OneOffPaymentRequest, @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) -> Void

public protocol ProductDetailDependenciesType {
    var oneOffPaymentRequester: OneOffPaymentRequester { get }
    var formatAsCurrency: CurrencyFormatter { get }
    var theme: ThemeProvider { get }
}

public struct ProductDetailDependencies: ProductDetailDependenciesType {
    public let oneOffPaymentRequester: OneOffPaymentRequester
    public let formatAsCurrency: CurrencyFormatter
    public let theme: ThemeProvider
    
    public init(
        oneOffPaymentRequester: @escaping OneOffPaymentRequester,
        formatAsCurrency: @escaping CurrencyFormatter,
        theme: ThemeProvider
    ) {
        self.oneOffPaymentRequester = oneOffPaymentRequester
        self.formatAsCurrency = formatAsCurrency
        self.theme = theme
    }
}
