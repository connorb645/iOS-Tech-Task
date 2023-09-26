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

final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var dependenciesMock: LoginDependenciesMock!
    var coordinatorSpy: LoginCoordinatorSpy!
    
    override func setUp() {
        super.setUp()
        dependenciesMock = LoginDependenciesMock()
        coordinatorSpy = LoginCoordinatorSpy(
            router: RoutingSpy(),
            dependencies: dependenciesMock
        )
        viewModel = LoginViewModel(
            dependencies: dependenciesMock,
            coordinator: coordinatorSpy
        )
    }
    
    override func tearDown() {
        viewModel = nil
        dependenciesMock = nil
        coordinatorSpy = nil
        super.tearDown()
    }
    
    func test_attemptLoginWithInvalidCredentials() {
        var error: String?
        viewModel.setError = { errorMessage in
            error = errorMessage
        }
        
        viewModel.attemptLogin(with: .init(email: "invalid", password: "password"))
        
        XCTAssertEqual(error, "Missing email address or password. Please check and try again.")
    }
    
    func test_attemptLoginWithValidCredentials() {
        viewModel.attemptLogin(with: .init(email: "valid@example.com", password: "password123"))
        
        XCTAssertTrue(dependenciesMock.loginCalled)
    }
    
    func test_attemptLoginWithSuccessfulResponse() {
        // TODO: - Use the provided mock test data in MoneyBoxTests/ResponseJsons/LoginSucceed
        let successReponse = LoginResponse(
            session: .init(bearerToken: "token123"),
            user: .init(
                firstName: "John",
                lastName: "Lennon"
            )
        )
        dependenciesMock.loginResult = .success(successReponse)
        
        let expectation = self.expectation(description: "Login completion expectation")
        
        var isLoading: Bool = false
        viewModel.setIsLoading = { loading in
            isLoading = loading
            if !isLoading {
                expectation.fulfill()
            }
        }
        
        viewModel.attemptLogin(with: .init(email: "valid@example.com", password: "password123"))
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual((dependenciesMock.sessionManager as? SessionManagerMock)?.userToken, "token123")
        XCTAssertTrue(coordinatorSpy.handleSuccessfulLoginCalled)
        XCTAssertFalse(isLoading)
    }
    
    func test_attemptLoginWithErrorResponse() {
        let error = NSError(domain: "Test", code: 123, userInfo: nil)
        dependenciesMock.loginResult = .failure(error)
        
        let expectation = self.expectation(description: "Login completion expectation")
        
        var receivedError: String?
        viewModel.setError = { errorMessage in
            receivedError = errorMessage
            if receivedError != nil {
                expectation.fulfill()
            }
        }
        
        viewModel.attemptLogin(with: .init(email: "valid@example.com", password: "password123"))
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(receivedError, error.localizedDescription)
    }
}
