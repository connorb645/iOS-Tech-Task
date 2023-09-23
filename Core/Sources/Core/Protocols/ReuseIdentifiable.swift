//
//  ReuseIdentifiable.swift
//  
//
//  Created by Connor Black on 23/09/2023.
//

import Foundation

public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
