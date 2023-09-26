//
//  CurrencyFormatter.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation

public func formatAsCurrency(amount: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    guard let currency = currencyFormatter.string(from: NSNumber(value: amount)) else {
        return ""
    }
    return currency
}
