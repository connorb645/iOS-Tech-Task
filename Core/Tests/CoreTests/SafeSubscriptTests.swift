//
//  SafeSubscriptTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation
import XCTest
@testable import Core

final class SafeSubscriptTests: XCTestCase {
    
    func test_SafeSubscriptWithArray() {
        let array = [1, 2, 3, 4, 5]
        
        // Valid indices
        XCTAssertEqual(array[safe: 0], 1)
        XCTAssertEqual(array[safe: 2], 3)
        XCTAssertEqual(array[safe: 4], 5)
        
        // Invalid indices
        XCTAssertNil(array[safe: -1])
        XCTAssertNil(array[safe: 5])
        XCTAssertNil(array[safe: 100])
    }
    
    func test_afeSubscriptWithString() {
        let string = "hello"
            
        // Valid indices
        XCTAssertEqual(string[safe: string.startIndex], "h")
        XCTAssertEqual(string[safe: string.index(string.startIndex, offsetBy: 4)], "o")
        
        // Invalid indices
        XCTAssertNil(string[safe: string.endIndex])
    }
    
    func test_safeSubscriptWithEmptyArray() {
        let emptyArray: [Int] = []
        
        // Invalid indices
        XCTAssertNil(emptyArray[safe: 0])
        XCTAssertNil(emptyArray[safe: -1])
        XCTAssertNil(emptyArray[safe: 1])
    }
    
    func test_safeSubscriptWithEmptyString() {
        let emptyString = ""
        
        // Invalid indices
        let startIndex = emptyString.startIndex
        XCTAssertNil(emptyString[safe: startIndex])
    }
}
