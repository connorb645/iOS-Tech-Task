//
//  RoutingTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import XCTest
import Foundation
import UIKit
@testable import Coordinating

final class RoutingTests: XCTestCase {
    var navigationController: UINavigationControllerSpy!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationControllerSpy()
    }
    
    override func tearDown() {
        navigationController = nil
        super.tearDown()
    }
    
    func test_push() {
        let viewController = UIViewController()
        navigationController.push(viewController, animated: true, canGoBack: false)
        
        XCTAssertTrue(navigationController.pushedViewController === viewController)
        XCTAssertTrue(navigationController.pushAnimated)
        XCTAssertTrue(viewController.navigationItem.hidesBackButton)
    }
    
    func test_dismiss() {
        navigationController.dismiss(animated: true)
        XCTAssertTrue(navigationController.dismissAnimated)
    }
    
    func test_popToRoot() {
        navigationController.popToRoot(animated: true)
        XCTAssertTrue(navigationController.popToRootAnimated)
    }
    
    func test_present() {
        let viewController = UIViewController()
        navigationController.present(viewController, animated: true)
        
        XCTAssertTrue(navigationController.spyPresentedViewController === viewController)
        XCTAssertTrue(navigationController.presentAnimated)
    }
}

final class UINavigationControllerSpy: UINavigationController {
    
    var pushedViewController: UIViewController?
    var pushAnimated: Bool = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        pushAnimated = animated
    }
    
    var dismissAnimated: Bool = false
    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        dismissAnimated = animated
    }
    
    var popToRootAnimated: Bool = false
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootAnimated = animated
        return nil
    }
    
    var spyPresentedViewController: UIViewController?
    var presentAnimated: Bool = false
    override func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        spyPresentedViewController = viewController
        presentAnimated = animated
    }
}
