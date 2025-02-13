//
//  AppDependencies.swift
//  MoneyBox
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import FeatureLogin
import FeatureAccounts
import Network

struct AppDependencies {
    let loginDependencies: LoginDependenciesType
    let accountsListDependencies: AccountsListDependencies
            
    init(
        loginDependencies: LoginDependenciesType,
        accountsListDependencies: AccountsListDependencies
    ) {
        self.loginDependencies = loginDependencies
        self.accountsListDependencies = accountsListDependencies
    }
}
