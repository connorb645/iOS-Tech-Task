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
import Network

struct AppDependencies {
    let loginDependencies: LoginDependencies
    let accountsListDependencies: AccountsListDependencies
            
    init(
        loginDependencies: LoginDependencies,
        accountsListDependencies: AccountsListDependencies
    ) {
        self.loginDependencies = loginDependencies
        self.accountsListDependencies = accountsListDependencies
    }
}
