//
//  EmailValidator.swift
//  
//
//  Created by Connor Black on 23/09/2023.
//

import Foundation

public struct EmailValidator: Validator {
    public init() {}
    public func isValid(_ value: String) -> Bool {
        let pattern = "^[A-Z0-9a-z._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,64}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: value.utf16.count)
        return regex?.firstMatch(in: value, options: [], range: range) != nil
    }
}
