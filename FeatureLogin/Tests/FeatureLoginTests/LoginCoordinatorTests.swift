//
//  LoginCoordinatorTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import XCTest
import Foundation
import Coordinating
import Networking
import SharedTestUtils
@testable import FeatureLogin

final class LoginCoordinatorTests: XCTestCase {
    var coordinator: LoginCoordinator!
    
    var routerMock: RouterMock!
    var dependenciesMock: LoginDependenciesMock!
    
    override func setUp() {
        super.setUp()
        routerMock = RouterMock()
        dependenciesMock = LoginDependenciesMock()
        coordinator = LoginCoordinator(
            router: routerMock,
            dependencies: dependenciesMock
        )
    }
    
    override func tearDown() {
        coordinator = nil
        routerMock = nil
        dependenciesMock = nil
        super.tearDown()
    }
    
    func test_start() {
        let pushInvocation: RouterMock.PushInvocation = .init(
            animated: true,
            canGoBack: false
        )
        
        coordinator.start(isAnimated: true, canGoBack: false)
        
        let pushInvocations = routerMock.methodCalls.filter { $0 == .push(Input(pushInvocation)) }
        XCTAssertEqual(pushInvocations.count, 1)
    }
    
    func test_handleSuccessfulLogin() {
        let mockUser = LoginResponse.User.init(firstName: "Test", lastName: "Name")
        coordinator.handleSuccessfulLogin(user: mockUser)
        
        let successfulLoginHandlerInvocations = dependenciesMock.methodCalls.filter { $0 == .successfullyLoggedInInvoked(.init(mockUser)) }
        XCTAssertEqual(successfulLoginHandlerInvocations.count, 1)
    }
}
