//
//  Router.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import UIKit

public protocol Routing {
    func push(_ viewController: UIViewController, animated: Bool)
}

extension UINavigationController: Routing {
    public func push(_ viewController: UIViewController, animated: Bool) {
        self.pushViewController(viewController, animated: animated)
    }
}
