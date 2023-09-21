//
//  AccountsListDependencies.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import Networking
import Persistence

public struct AccountsListDependencies {
    let authPersistence: Auth
    let logoutHandler: () -> Void
    
    public init(
        authPersistence: Auth,
        logoutHandler: @escaping () -> Void
    ) {
        self.authPersistence = authPersistence
        self.logoutHandler = logoutHandler
    }
}
