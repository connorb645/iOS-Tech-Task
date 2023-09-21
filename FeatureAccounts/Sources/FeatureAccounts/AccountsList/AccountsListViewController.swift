//
//  AccountsListViewController.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import Core

final public class AccountsListViewController: ViewController<AccountsListViewModel, AccountsListView> {
    public init(viewModel: AccountsListViewModel) {
        super.init(
            view: AccountsListView(
                viewModel: viewModel
            )
        )
        title = "Accounts List"
    }
}
