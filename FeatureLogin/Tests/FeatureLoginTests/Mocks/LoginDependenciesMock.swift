//
//  LoginDependenciesMock.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Core
import XCTest
import Foundation
import Networking
import Coordinating
import SharedTestUtils
@testable import FeatureLogin

final class LoginDependenciesMock: LoginDependenciesType {
    enum MethodCall: Equatable {
        case successfullyLoggedInInvoked
        case loginInvoked(InputOutput<LoginRequest, Result<LoginResponse, EquatableError>>)
    }
    
    var sessionManager: SessionManagerType = SessionManagerMock()
    var emailValidator: Validator = EmailValidatorMock()
    var passwordValidator: Validator = PasswordValidatorMock()
    
    init(
        sessionManager: SessionManagerType = SessionManagerMock(),
        emailValidator: Validator = EmailValidatorMock(),
        passwordValidator: Validator = PasswordValidatorMock()
    ) {
        self.sessionManager = sessionManager
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
    }
    
    var methodCalls: [MethodCall] = []
    
    var successfulLoginHandler: (Routing) -> Void {
        return { [weak self] router in
            guard let self else { return }
            methodCalls.append(.successfullyLoggedInInvoked)
        }
    }
    
    var loginResult: Result<LoginResponse, Error>?
    var login: LoginAPIRequest {
        return { [weak self] request, completion in
            guard let self else { return }
            guard let loginResult else {
                XCTFail("loginResult not set.")
                return
            }
            let equatableResult = loginResult.mapError { EquatableError($0) }
            methodCalls.append(.loginInvoked(.init(input: .init(request), output: .init(equatableResult))))
            completion(loginResult)
        }
    }
}
