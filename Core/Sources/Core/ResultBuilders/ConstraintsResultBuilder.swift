//
//  ConstraintsResultBuilder.swift
//  
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import UIKit

@resultBuilder
public enum ConstraintsResultBuilder {
    /// Combines multiple arrays of `NSLayoutConstraint`s into a single array.
    ///
    /// - Parameter views: A variadic parameter containing arrays of `NSLayoutConstraint`s.
    /// - Returns: A flattened array containing all the `NSLayoutConstraint`s.
    public static func buildBlock(_ constraints: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        constraints.flatMap { $0 }
    }

    /// Creates an array of `NSLayoutConstraint`s containing a single `NSLayoutConstraint` from a given expression.
    ///
    /// - Parameter expression: A `NSLayoutConstraint` to be wrapped in an array.
    /// - Returns: An array containing the single `NSLayoutConstraint`.
    public static func buildExpression(_ constraint: NSLayoutConstraint) -> [NSLayoutConstraint] {
        [constraint]
    }

    /// Returns the given array of `NSLayoutConstraint`s without any modifications.
    ///
    /// - Parameter expression: An array of `NSLayoutConstraint`s.
    /// - Returns: The same input array of `NSLayoutConstraint`s.
    public static func buildExpression(_ constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        constraints
    }

    /// Returns an array of `NSLayoutConstraint`s from an optional array of `NSLayoutConstraint`s. If the input is nil, it returns an empty array.
    ///
    /// - Parameter views: An optional array of `NSLayoutConstraint`s.
    /// - Returns: An array of `NSLayoutConstraint`s, empty if the input is nil.
    public static func buildOptional(_ constraints: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
        constraints ?? []
    }

    /// Returns the given array of `NSLayoutConstraint`s when building an `Either` expression with two cases, and the first case is selected.
    ///
    /// - Parameter views: An array of `NSLayoutConstraint`s.
    /// - Returns: The same input array of `NSLayoutConstraint`s.
    public static func buildEither(first constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        constraints
    }

    /// Returns the given array of `NSLayoutConstraint`s when building an `Either` expression with two cases, and the second case is selected.
    ///
    /// - Parameter views: An array of `NSLayoutConstraint`s.
    /// - Returns: The same input array of `NSLayoutConstraint`s.
    public static func buildEither(second constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        constraints
    }
}
