//
//  SessionManagerMock.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation
import Networking

final class SessionManagerMock: SessionManagerType {
    var userToken: String?
    func setUserToken(_ token: String) {
        userToken = token
    }
    func removeUserToken() { }
}
