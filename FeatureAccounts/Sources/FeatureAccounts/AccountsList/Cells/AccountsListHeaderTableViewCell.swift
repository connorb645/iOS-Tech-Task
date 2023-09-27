//
//  AccountsListHeaderTableViewCell.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Foundation
import CoreUI
import UIKit
import Core

final class AccountsListHeaderTableViewCell: UITableViewCell, ReuseIdentifiable {
    struct CellConfigurationData {
        let displayName: String
        let totalPlanValue: Double?
        let formatAsCurrency: CurrencyFormatter
        let theme: ThemeProvider
        
        init(
            displayName: String,
            totalPlanValue: Double?,
            formatAsCurrency: @escaping CurrencyFormatter,
            theme: ThemeProvider
        ) {
            self.displayName = displayName
            self.totalPlanValue = totalPlanValue
            self.formatAsCurrency = formatAsCurrency
            self.theme = theme
        }
    }
    
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = data?.theme.background ?? .white
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(welcomeLabel)
        view.addArrangedSubview(totalPlanLabel)
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.textColor = data?.theme.font ?? .white
        return label
    }()
    
    private lazy var totalPlanLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = data?.theme.font ?? .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    private var data: CellConfigurationData?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerContainer.removeFromSuperview()
    }
    
    func configure(with data: CellConfigurationData) {
        contentView.backgroundColor = data.theme.background
        self.data = data
        setupConstraints()
        welcomeLabel.text = "Hey \(data.displayName)! 👋"
        if let planValue = data.totalPlanValue {
            let planCurrency = data.formatAsCurrency(planValue)
            totalPlanLabel.text = "Your total plan value is \(planCurrency)"
        }
    }
    
    private func setupConstraints() {
        
        addSubview(headerContainer)
        headerContainer.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 0)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        }
        
        headerContainer.addSubview(headerStackView)
        headerStackView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16)
            $0.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 32)
            $0.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
