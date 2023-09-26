//
//  LoginDependenciesMock.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Core
import Foundation
import Networking
import Coordinating
@testable import FeatureLogin

final class LoginDependenciesMock: LoginDependenciesType {
    var sessionManager: SessionManagerType = SessionManagerMock()
    var emailValidator: Validator = EmailValidatorMock()
    var passwordValidator: Validator = PasswordValidatorMock()
    
    var successfulLoginHandler: (Routing) -> Void {
        return { [weak self] router in
            guard let self else { return }
            successfulLoginHandlerCalled = true
            passedRouter = router
        }
    }
    
    var login: LoginAPIRequest {
        return { [weak self] request, completion in
            guard let self else { return }
            loginCalled = true
            completion(loginResult)
        }
    }
    
    var successfulLoginHandlerCalled: Bool = false
    var passedRouter: Routing?
    var loginCalled: Bool = false
    var loginResult: Result<LoginResponse, Error> = .failure(NSError(domain: "", code: 0, userInfo: nil))
}
