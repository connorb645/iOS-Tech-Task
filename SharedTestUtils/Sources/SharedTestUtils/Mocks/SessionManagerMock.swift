//
//  SessionManagerMock.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation
@testable import Networking

final public class SessionManagerMock: SessionManagerType {
    public enum MethodCall: Equatable {
        case setUserToken(Input<String>)
        case removeUserToken
    }
    
    public var userToken: String?
    public var methodCalls: [MethodCall] = []
    
    public init(userToken: String? = nil) {
        self.userToken = userToken
    }
    
    public func setUserToken(_ token: String) {
        userToken = token
        methodCalls.append(.setUserToken(.init(token)))
    }
    
    public func removeUserToken() {
        userToken = nil
        methodCalls.append(.removeUserToken)
    }
    
    public func reset() {
        methodCalls.removeAll()
    }
}
