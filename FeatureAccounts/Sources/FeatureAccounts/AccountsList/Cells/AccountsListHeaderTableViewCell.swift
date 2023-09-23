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
    }

    private func label(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        return label
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func configure(with data: CellConfigurationData) {
        let welcomeMessage = "Hey \(data.displayName)! 👋"
        stackView.addArrangedSubview(label(welcomeMessage))        
        if let planValue = data.totalPlanValue {
            stackView.addArrangedSubview(label("Your total plan value is £\(planValue)"))
        }
    }
    
    private func setupConstraints() {
        addSubview(stackView)
        stackView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 8)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
