//
//  Router.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import UIKit

public protocol Routing {
    func push(_ viewController: UIViewController, animated: Bool, canGoBack: Bool)
    func dismiss(animated: Bool)
    func popToRoot(animated: Bool)
}

extension UINavigationController: Routing {
    public func push(_ viewController: UIViewController, animated: Bool, canGoBack: Bool) {
        self.pushViewController(viewController, animated: animated)
        if !canGoBack {
            viewController.navigationItem.hidesBackButton = true
            viewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    public func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }
    
    public func popToRoot(animated: Bool) {
        self.popToRootViewController(animated: animated)
    }
}
