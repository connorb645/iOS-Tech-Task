//
//  LoginViewModelTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation

import Core
import XCTest
import Networking
@testable import FeatureLogin
import SharedTestUtils

final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var dependenciesMock: LoginDependenciesMock!
    var coordinatorMock: LoginCoordinatorMock!
    var routerMock: RouterMock!
    var sessionManagerMock: SessionManagerMock!
    
    override func setUp() {
        super.setUp()
        sessionManagerMock = SessionManagerMock()
        dependenciesMock = LoginDependenciesMock(sessionManager: sessionManagerMock)
        routerMock = RouterMock()
        coordinatorMock = LoginCoordinatorMock(router: routerMock)
        viewModel = LoginViewModel(
            dependencies: dependenciesMock,
            coordinator: coordinatorMock
        )
    }
    
    override func tearDown() {
        viewModel = nil
        dependenciesMock = nil
        coordinatorMock = nil
        routerMock = nil
        super.tearDown()
    }
    
    func test_attemptLoginWithInvalidCredentials() {
        var setErrorInvocations: [String] = []
        viewModel.setError = { errorMessage in
            setErrorInvocations.append(errorMessage ?? "")
        }
        
        viewModel.attemptLogin(with: .init(email: "invalid", password: "password"))
        
        XCTAssertEqual(setErrorInvocations.count, 1)
        XCTAssertEqual(setErrorInvocations[0], "Missing email address or password. Please check and try again.")
        XCTAssertEqual([], dependenciesMock.methodCalls)
    }
    
    func test_attemptLoginWithSuccessfulResponse() {
        // GIVEN
        let request = LoginRequest(email: "valid@example.com", password: "password123")
        let response = LoginResponse(
            session: .init(
                bearerToken: "Fake_token"
            ),
            user: .init(
                firstName: "John",
                lastName: "Lennon"
            )
        )
        dependenciesMock.loginResult = .success(response)
        let isLoadingExpectation = self.expectation(description: "Attempt login loading finished expectation")
        var isLoadingInvocations: [Bool] = []
        viewModel.setIsLoading = { isLoading in
            isLoadingInvocations.append(isLoading)
            if !isLoading {
                isLoadingExpectation.fulfill()
            }
        }
        
        
        var setErrorInvocations: [String?] = []
        viewModel.setError = { message in
            setErrorInvocations.append(message)
        }
        
        // WHEN
        viewModel.attemptLogin(
            with: .init(
                email: request.email,
                password: request.password
            )
        )
        waitForExpectations(timeout: 1)
        
        // THEN
        // Ensure that the isLoading setter is invoced 2 times exactly, with the correct values
        XCTAssertEqual([true, false], isLoadingInvocations)
        // Ensure that the error setter is invoked 1 time exactly, with the correct value
        XCTAssertEqual([nil], setErrorInvocations)
        // Ensure that the dependencies class calls login handler exactly 1 time
        let loginInvokations = dependenciesMock.methodCalls.filter { $0 == .loginInvoked(.init(input: .init(request), output: .init(.success(response)))) }
        XCTAssertEqual(loginInvokations.count, 1)
        // Ensure that the session manager sets the user token with the correct token
        let setUserTokenInvocations = sessionManagerMock.methodCalls.filter { $0 == .setUserToken(.init("Fake_token")) }
        XCTAssertEqual(setUserTokenInvocations.count, 1)
        // Ensure that coordinator calls handleSuccessfulLogin exactly once
        let successfulLoginInvokations = coordinatorMock.methodCalls.filter { $0 == .handleSuccessfulLogin }
        XCTAssertEqual(successfulLoginInvokations.count, 1)
    }
    
    func test_attemptLoginWithErrorResponse() {
        // GIVEN
        let request = LoginRequest(email: "valid@example.com", password: "password123")
        let error = NSError(domain: "Test", code: 123, userInfo: nil)
        let equatableResult: Result<LoginResponse, EquatableError> = .failure(.init(error))
        dependenciesMock.loginResult = .failure(error)
        
        let isLoadingExpectation = self.expectation(description: "Attempt login loading finished expectation")
        var isLoadingInvocations: [Bool] = []
        viewModel.setIsLoading = { isLoading in
            isLoadingInvocations.append(isLoading)
            if !isLoading {
                isLoadingExpectation.fulfill()
            }
        }
        
        
        var setErrorInvocations: [String?] = []
        viewModel.setError = { message in
            setErrorInvocations.append(message)
        }
        
        // WHEN
        viewModel.attemptLogin(
            with: .init(
                email: request.email,
                password: request.password
            )
        )
        waitForExpectations(timeout: 1)
        
        // THEN
        // Ensure that the isLoading setter is invoced 2 times exactly, with the correct values
        XCTAssertEqual([true, false], isLoadingInvocations)
        // Ensure that the dependencies class calls login handler exactly 1 time
        let loginInvokations = dependenciesMock.methodCalls.filter { $0 == .loginInvoked(.init(input: .init(request), output: .init(equatableResult))) }
        XCTAssertEqual(loginInvokations.count, 1)
        // Ensure that coordinator does not call handleSuccessfulLogin
        let successfulLoginInvokations = coordinatorMock.methodCalls.filter { $0 == .handleSuccessfulLogin }
        XCTAssertEqual(successfulLoginInvokations.count, 0)
    }
}
