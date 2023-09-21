//
//  Validator.swift
//  
//
//  Created by Connor Black on 23/09/2023.
//

import Foundation

public protocol Validator {
    func isValid(_ value: String) -> Bool
}
