//
//  LoginCoordinatorSpy.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation
import Networking
import Coordinating
import SharedTestUtils
@testable import FeatureLogin

final class LoginCoordinatorMock: LoginCoordinatorType {
    struct StartInvocation: Equatable {
        let isAnimated: Bool
        let canGoBack: Bool
    }
    
    enum MethodCall: Equatable {
        case handleSuccessfulLogin(LoginResponse.User)
        case start(StartInvocation)
    }
    
    var children: [Coordinating] = []
    var router: Routing
    var methodCalls: [MethodCall] = []
    
    init(router: Routing) {
        self.router = router
    }
    
    func start(isAnimated: Bool, canGoBack: Bool) {
        methodCalls.append(.start(.init(isAnimated: isAnimated, canGoBack: canGoBack)))
    }
    
    func handleSuccessfulLogin(user: LoginResponse.User) {
        methodCalls.append(.handleSuccessfulLogin(user))
    }
}
