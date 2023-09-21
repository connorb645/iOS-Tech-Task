//
//  PasswordValidator.swift
//  
//
//  Created by Connor Black on 23/09/2023.
//

import Foundation

public struct PasswordValidator: Validator {
    public init() {}
    public func isValid(_ value: String) -> Bool {
        return !value.isEmpty
    }
}
