//
//  LoginCoordinatorTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import XCTest
import Foundation
import Coordinating
@testable import FeatureLogin

final class LoginCoordinatorTests: XCTestCase {
    var coordinator: LoginCoordinator!
    var routerSpy: RoutingSpy!
    var dependenciesMock: LoginDependenciesMock!
    
    override func setUp() {
        super.setUp()
        routerSpy = RoutingSpy()
        dependenciesMock = LoginDependenciesMock()
        coordinator = LoginCoordinator(router: routerSpy, dependencies: dependenciesMock)
    }
    
    override func tearDown() {
        coordinator = nil
        routerSpy = nil
        dependenciesMock = nil
        super.tearDown()
    }
    
    func test_start() {
        coordinator.start(isAnimated: true, canGoBack: false)
        
        XCTAssertTrue(routerSpy.pushedViewController is LoginViewController)
        XCTAssertTrue(routerSpy.pushAnimated)
        XCTAssertFalse(routerSpy.canGoBack)
    }
    
    func test_handleSuccessfulLogin() {
        coordinator.handleSuccessfulLogin()
        
        XCTAssertTrue(dependenciesMock.successfulLoginHandlerCalled)
        XCTAssertTrue(dependenciesMock.passedRouter === routerSpy)
    }
}

final class RoutingSpy: Routing {
    var pushedViewController: UIViewController?
    var pushAnimated: Bool = false
    var canGoBack: Bool = true
    
    func push(_ viewController: UIViewController, animated: Bool, canGoBack: Bool) {
        pushedViewController = viewController
        pushAnimated = animated
        self.canGoBack = canGoBack
    }
    
    func dismiss(animated: Bool) {}
    func popToRoot(animated: Bool) {}
    func present(_ viewController: UIViewController, animated: Bool) {}
}
