//
//  Collection+Extensions.swift
//  
//
//  Created by Connor Black on 25/09/2023.
//

import Foundation

extension Collection {
    public subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
