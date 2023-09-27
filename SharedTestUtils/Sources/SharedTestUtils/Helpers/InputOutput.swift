//
//  FInputOutputile.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import Foundation

public struct Input<I: Equatable>: Equatable {
    public let input: I
    public init(_ input: I) {
        self.input = input
    }
}

public struct Output<O: Equatable>: Equatable {
    public let output: O
    public init(_ output: O) {
        self.output = output
    }
}

public struct InputOutput<I: Equatable, O: Equatable>: Equatable {
    public let input: Input<I>
    public let output: Output<O>
    
    public init(input: Input<I>, output: Output<O>) {
        self.input = input
        self.output = output
    }
}
