//
//  EmailValidatorTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import XCTest
import Foundation
@testable import Core

final class EmailValidatorTests: XCTestCase {
    func testValidEmail() {
        let validator = EmailValidator()
        
        XCTAssertTrue(validator.isValid("test@example.com"))
        XCTAssertTrue(validator.isValid("firstname.lastname@example.co.uk"))
        XCTAssertTrue(validator.isValid("email+filter@example.com"))
    }
    
    func testInvalidEmail() {
        let validator = EmailValidator()
        
        XCTAssertFalse(validator.isValid(""))
        XCTAssertFalse(validator.isValid("plainaddress"))
        XCTAssertFalse(validator.isValid("@missingusername.com"))
        XCTAssertFalse(validator.isValid("username@.com"))
        XCTAssertFalse(validator.isValid("username@.com."))
        XCTAssertFalse(validator.isValid("username@server..com"))
    }
}
