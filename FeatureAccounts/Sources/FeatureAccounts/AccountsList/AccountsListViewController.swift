//
//  AccountsListViewController.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation
import Core

final public class AccountsListViewController: ViewController<AccountsListViewModel, AccountsListView> {
    let viewModel: AccountsListViewModel
    public init(viewModel: AccountsListViewModel) {
        self.viewModel = viewModel
        super.init(
            view: AccountsListView(viewModel: viewModel)
        )
        view.backgroundColor = viewModel.theme.background
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchProducts()
        navigationItem.setRightBarButtonItems([.init(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))], animated: false)
    }
    
    @objc
    private func logoutTapped() {
        viewModel.logout()
    }
}
