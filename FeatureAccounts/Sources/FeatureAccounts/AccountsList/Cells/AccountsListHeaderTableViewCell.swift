//
//  AccountsListHeaderTableViewCell.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Foundation
import UIKit
import Core

final class AccountsListHeaderTableViewCell: UITableViewCell, ReuseIdentifiable {
    struct CellConfigurationData {
        let displayName: String
        let totalPlanValue: Double?
        let formatAsCurrency: CurrencyFormatter
        
        init(
            displayName: String,
            totalPlanValue: Double?,
            formatAsCurrency: @escaping CurrencyFormatter
        ) {
            self.displayName = displayName
            self.totalPlanValue = totalPlanValue
            self.formatAsCurrency = formatAsCurrency
        }
    }
    
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
        label.textColor = .white
        return label
    }()
    
    private lazy var totalPlanLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerContainer.removeFromSuperview()
    }
    
    func configure(with data: CellConfigurationData) {
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
            $0.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 64)
            $0.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
