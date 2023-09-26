//
//  EmailValidatorMock.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation
import Core

final class EmailValidatorMock: Validator {
    func isValid(_ value: String) -> Bool {
        return value == "valid@example.com"
    }
}
