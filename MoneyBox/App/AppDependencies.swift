//
//  AppDependencies.swift
//  MoneyBox
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import FeatureLogin
import FeatureAccounts
import Persistence

struct AppDependencies {
    let loginDependencies: LoginDependencies
    let accountsListDependencies: AccountsListDependencies
    let authPersistence: Auth
            
    init(
        loginDependencies: LoginDependencies,
        accountsListDependencies: AccountsListDependencies,
        authPersistence: Auth
    ) {
        self.loginDependencies = loginDependencies
        self.accountsListDependencies = accountsListDependencies
        self.authPersistence = authPersistence
    }
}
