//
//  ProductCollectionViewCell.swift
//  
//
//  Created by Connor Black on 25/09/2023.
//

import Foundation
import UIKit
import CoreUI
import Core

final class ProductCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    struct CellConfigurationData {
        let formatAsCurrency: CurrencyFormatter
        let id: Int?
        let title: String?
        let moneybox: Double?
        let planValue: Double?
        let theme: ThemeProvider
        
        init(
            id: Int?,
            title: String?,
            moneybox: Double?,
            planValue: Double?,
            formatAsCurrency: @escaping CurrencyFormatter,
            theme: ThemeProvider
        ) {
            self.formatAsCurrency = formatAsCurrency
            self.id = id
            self.title = title
            self.moneybox = moneybox
            self.planValue = planValue
            self.theme = theme
        }
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = data?.theme.backgroundOffset ?? .lightGray
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = data?.theme.font ?? .white
        return label
    }()

    private lazy var planValueInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Plan Value:"
        label.textColor = data?.theme.font ?? .white
        return label
    }()
    
    private lazy var planValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = data?.theme.font ?? .white
        return label
    }()

    private lazy var moneyboxInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Moneybox:"
        label.textColor = data?.theme.font ?? .white
        return label
    }()
    
    private lazy var moneyboxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.textColor = data?.theme.font ?? .white
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(moneyboxInfoLabel)
        stackView.addArrangedSubview(moneyboxLabel)
        stackView.addArrangedSubview(planValueInfoLabel)
        stackView.addArrangedSubview(planValueLabel)
        return stackView
    }()
    
    private var data: CellConfigurationData?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.activateConstraints {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        
        containerView.addSubview(stackView)
        stackView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        }
    }
    
    func configure(with data: CellConfigurationData) {
        self.data = data
        setupConstraints()
        let title = data.title ?? ""
        titleLabel.text = title
        let moneybox = data.moneybox ?? 0.0
        let planValue = data.planValue ?? 0.0
        moneyboxLabel.text = data.formatAsCurrency(moneybox)
        planValueLabel.text = data.formatAsCurrency(planValue)
        
        accessibilityLabel = "Your \(title) Plan. You have a Moneybox value of: \(data.formatAsCurrency(moneybox)). And a plan value of: \(data.formatAsCurrency(planValue))"
    }
}
