//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import Networking

final class LoginViewModel {
    struct Credentials {
        let email: String
        let password: String
    }
    
    private let dependencies: LoginDependenciesType
    private let coordinator: LoginCoordinatorType
    
    lazy var bundle: Bundle = {
        dependencies.bundle
    }()
    var setError: ((String?) -> Void)?
    var setIsLoading: ((Bool) -> Void)?
    
    init(
        dependencies: LoginDependenciesType,
        coordinator: LoginCoordinatorType
    ) {
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func attemptLogin(with credentials: Credentials) {
        guard dependencies.emailValidator.isValid(credentials.email),
              dependencies.passwordValidator.isValid(credentials.password) else {
            setError?("Missing email address or password. Please check and try again.")
            return
        }
        
        setError?(nil)
        setIsLoading?(true)
        
        let request = LoginRequest(
            email: credentials.email,
            password: credentials.password
        )
        dependencies.login(request, { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success(let response):
                    self.dependencies.sessionManager.setUserToken(response.session.bearerToken)
                    self.coordinator.handleSuccessfulLogin()
                case .failure(let error):
                    self.setError?(error.localizedDescription)
                }
                self.setIsLoading?(false)
            }
        })
    }
}
