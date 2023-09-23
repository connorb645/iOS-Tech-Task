//
//  AccountsListView.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Core
import UIKit
import Foundation

final public class AccountsListView: View<AccountsListViewModel> {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.alpha = 0.0
        tableView.register(
            AccountTableViewCell.self,
            forCellReuseIdentifier: AccountTableViewCell.reuseIdentifier
        )
        tableView.register(
            AccountsListHeaderTableViewCell.self,
            forCellReuseIdentifier: AccountsListHeaderTableViewCell.reuseIdentifier
        )
        return tableView
    }()
    
    private lazy var activityLoader: UIActivityIndicatorView = {
        let activityLoader = UIActivityIndicatorView()
        activityLoader.color = .lightGray
        activityLoader.hidesWhenStopped = true
        return activityLoader
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "It doesn't look like you have set up any accounts yet."
        return label
    }()
    
    override init(viewModel: AccountsListViewModel) {
        super.init(viewModel: viewModel)
        bindViewModelActions()
    }
    
    private func bindViewModelActions() {
        viewModel.onProductsFetchComplete = { [weak self] in
            guard let self else { return }
            if viewModel.hasAccounts {
                tableView.reloadData()
            }
        }
        
        viewModel.setIsFetchingProducts = { [weak self] isFetching in
            guard let self else { return }
            
            let tableViewAlpha = viewModel.hasAccounts && !isFetching ? 1.0 : 0.0
            let emptyViewAlpha = !viewModel.hasAccounts && !isFetching ? 1.0 : 0.0
            
            if isFetching {
                activityLoader.startAnimating()
            } else {
                activityLoader.stopAnimating()
            }
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.tableView.alpha = tableViewAlpha
                self?.emptyLabel.alpha = emptyViewAlpha
            }
        }
    }

    
    public override func configureView() {
        super.configureView()
        addSubview(tableView)
        addSubview(activityLoader)
        tableView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.rightAnchor.constraint(equalTo: rightAnchor)
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        activityLoader.activateConstraints {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
        }
    }
}

extension AccountsListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let accountsCount = viewModel.accountProducts.count
        return accountsCount + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AccountsListHeaderTableViewCell.reuseIdentifier, for: indexPath) as? AccountsListHeaderTableViewCell,
           indexPath.row == 0 {
            cell.configure(with: .init(
                displayName: "Connor Black",
                totalPlanValue: viewModel.totalPlanValue
            ))
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.reuseIdentifier,for: indexPath) as? AccountTableViewCell,
                  let accountWithProducts = viewModel.accountProducts[safe: indexPath.row - 1] {
            cell.configure(with: .init(
                title: accountWithProducts.account.name,
                planValue: accountWithProducts.account.wrapper?.totalValue,
                earningsNet: accountWithProducts.account.wrapper?.earningsNet,
                earningsPercentage: accountWithProducts.account.wrapper?.earningsAsPercentage,
                products: accountWithProducts.products.map {
                    .init(
                        id: $0.id,
                        title: $0.product?.name,
                        moneybox: $0.moneybox
                    )
                }
            ))
            cell.didTapProduct = { [weak self] productId in
                guard let self else { return }
                viewModel.handleProductTapped(productId)
            }
            return cell
        }
        fatalError("Unable to deque \(AccountTableViewCell.reuseIdentifier)")
    }
}
