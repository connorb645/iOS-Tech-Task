//
//  LoginDependencies.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import Networking
import Coordinating
import Persistence
import Core

public struct LoginDependencies {
    public typealias LoginAPIRequest = (_ request: LoginRequest, _ completion: @escaping (Result<LoginResponse, Error>) -> Void) -> Void
    
    let authPersistence: Auth
    let login: LoginAPIRequest
    let successfulLoginHandler: (Routing) -> Void
    let emailValidator: Validator
    let passwordValidator: Validator
    
    public init(
        authPersistence: Auth,
        login: @escaping LoginAPIRequest,
        successfulLoginHandler: @escaping (Routing) -> Void,
        emailValidator: Validator,
        passwordValidator: Validator
    ) {
        self.authPersistence = authPersistence
        self.login = login
        self.successfulLoginHandler = successfulLoginHandler
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
    }
}
