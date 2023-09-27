//
//  LoginDependencies.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import Networking
import Coordinating
import CoreUI
import Core

public typealias LoginAPIRequest = (_ request: LoginRequest, _ completion: @escaping (Result<LoginResponse, Error>) -> Void) -> Void

public protocol LoginDependenciesType {
    var sessionManager: SessionManagerType { get }
    var login: LoginAPIRequest { get }
    var successfulLoginHandler: (Routing) -> Void { get }
    var emailValidator: Validator { get }
    var passwordValidator: Validator { get }
    var theme: ThemeProvider { get }
    var bundle: Bundle { get }
}

public struct LoginDependencies: LoginDependenciesType {
    public let sessionManager: SessionManagerType
    public let login: LoginAPIRequest
    public let successfulLoginHandler: (Routing) -> Void
    public let emailValidator: Validator
    public let passwordValidator: Validator
    public let theme: ThemeProvider
    public let bundle: Bundle
    
    public init(
        sessionManager: SessionManager,
        login: @escaping LoginAPIRequest,
        successfulLoginHandler: @escaping (Routing) -> Void,
        emailValidator: Validator,
        passwordValidator: Validator,
        theme: ThemeProvider,
        bundle: Bundle
    ) {
        self.sessionManager = sessionManager
        self.login = login
        self.successfulLoginHandler = successfulLoginHandler
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
        self.theme = theme
        self.bundle = bundle
    }
}
