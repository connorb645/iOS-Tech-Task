//
//  LoginCoordinatorSpy.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation
@testable import FeatureLogin

final class LoginCoordinatorSpy: LoginCoordinator {
    var handleSuccessfulLoginCalled = false
    override func handleSuccessfulLogin() {
        handleSuccessfulLoginCalled = true
    }
}
