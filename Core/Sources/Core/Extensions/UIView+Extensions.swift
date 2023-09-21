//
//  UIView+Extensions.swift
//  
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import UIKit

extension UIView {
    public func activateConstraints(
        @ConstraintsResultBuilder _ constraints: (UIView) -> [NSLayoutConstraint]
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints(self))
    }
}
