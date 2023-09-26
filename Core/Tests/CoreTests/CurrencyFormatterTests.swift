//
//  CurrencyFormatterTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import XCTest
import Foundation
@testable import Core

final class CurrencyFormatterTests: XCTestCase {
    
    func test_formatAsCurrency() {
        assertEqual(
            amount: 1234.56,
            result: "$1,234.56"
        )
    }
    
    func test_formatAsCurrencyWithZero() {
        assertEqual(
            amount: 0,
            result: "$0.00"
        )
    }
    
    func test_formatAsCurrencyWithLargeAmount() {
        assertEqual(
            amount: 1234567890.12,
            result: "$1,234,567,890.12"
        )
    }
    
    func test_formatAsCurrencyWithNegativeAmount() {
        assertEqual(
            amount: -1234.56,
            result: "-$1,234.56"
        )
    }
    
    func testFormatAsCurrencyWithGBP() {
        assertEqual(
            amount: 1234.56,
            result: "£1,234.56",
            locale: Locale(identifier: "en_GB")
        )
    }
    
    private func assertEqual(
        amount: Double,
        result: String,
        locale: Locale = Locale(identifier: "en_US"),
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let formattedAmount = formatAsCurrency(
            amount: amount,
            locale: locale
        )
        XCTAssertEqual(formattedAmount, result, file: file, line: line)
    }
}
