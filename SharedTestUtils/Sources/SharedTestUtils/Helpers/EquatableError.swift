//
//  EquatableError.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import Foundation

public enum EquatableError: LocalizedError, Equatable {
    case generic(Error)
    
    public init(_ error: Error) {
        self = .generic(error)
    }
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error.localizedDescription
        }
    }
    
    public static func == (lhs: EquatableError, rhs: EquatableError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
