//
//  PasswordValidatorTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import XCTest
import Foundation
@testable import Core

final class PasswordValidatorTests: XCTestCase {
    func test_validPassword() {
        let validator = PasswordValidator()
        XCTAssertTrue(validator.isValid("password123"))
    }
    
    func test_invalidPassword() {
        let validator = PasswordValidator()
        XCTAssertFalse(validator.isValid(""))
    }
}
