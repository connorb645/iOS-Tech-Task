//
//  ProductDetailView.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Core
import UIKit
import CoreUI
import Foundation

final public class ProductDetailView: View<ProductDetailViewModel> {
    
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = viewModel.theme.background
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(accountTitleLabel)
        view.addArrangedSubview(productTitleLabel)
        view.isAccessibilityElement = true
        view.accessibilityLabel = "Your \(productTitleLabel.text ?? "") plan, within your \(accountTitleLabel.text ?? "") account"
        return view
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.productTitle
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.textColor = viewModel.theme.font
        return label
    }()
    
    private lazy var accountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.accountTitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = viewModel.theme.font
        return label
    }()
    
    private lazy var planValueInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "This plans value is:"
        label.textColor = viewModel.theme.font
        return label
    }()
    
    private lazy var planValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.text = viewModel.formatAsCurrency(viewModel.planValue)
        label.textColor = viewModel.theme.font
        return label
    }()
    
    private lazy var moneyboxInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "The value in your moneybox is:"
        label.textColor = viewModel.theme.font
        return label
    }()
    
    private lazy var moneyboxLabel: CountingAnimatedLabel = {
        let label = CountingAnimatedLabel(
            startValue: viewModel.moneyboxValue) { [weak self] amount in
                guard let self else { return "" }
                return viewModel.formatAsCurrency(amount)
            }
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.text = viewModel.formatAsCurrency(viewModel.moneyboxValue)
        label.textColor = viewModel.theme.font
        return label
    }()
    
    private lazy var moneyboxContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(moneyboxInfoLabel)
        stackView.addArrangedSubview(moneyboxLabel)
        stackView.isAccessibilityElement = true
        stackView.accessibilityLabel = "\(moneyboxInfoLabel.text ?? ""), \(moneyboxLabel.text ?? "")"
        return stackView
    }()
    
    private lazy var planValueContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(planValueInfoLabel)
        stackView.addArrangedSubview(planValueLabel)
        stackView.isAccessibilityElement = true
        stackView.accessibilityLabel = "\(planValueInfoLabel.text ?? ""), \(planValueLabel.text ?? "")"
        return stackView
    }()
    
    private lazy var detailContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(moneyboxContentStackView)
        stackView.addArrangedSubview(planValueContentStackView)
        return stackView
    }()
    
    private lazy var topUpAccountButton: PrimaryButton = {
        let button = PrimaryButton(
            title: "Add \(viewModel.formatAsCurrency(Double(viewModel.topUpAmount)))",
            target: (self, #selector(topUpAccountButtonTapped)),
            color: viewModel.theme.accentColour
        )
        return button
    }()
        
    override init(viewModel: ProductDetailViewModel) {
        super.init(viewModel: viewModel)
        bindViewModelActions()
    }
    
    private func bindViewModelActions() {
        viewModel.setIsLoading = { [weak self] isLoading in
            guard let self else { return }
            topUpAccountButton.isLoading = isLoading
        }
        
        viewModel.newMoneyboxValueReceived = { [weak self] newValue in
            guard let self,
                  let newValue else { return }
            moneyboxLabel.updateAmount(to: newValue)
        }
    }
    
    @objc
    private func topUpAccountButtonTapped() {
        viewModel.addOneOffPayment(of: viewModel.topUpAmount)
    }

    public override func configureView() {
        super.configureView()
        addSubview(headerContainer)
        addSubview(detailContentStackView)
        addSubview(topUpAccountButton)
        
        headerContainer.activateConstraints {
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 0)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        }
        
        detailContentStackView.activateConstraints {
            $0.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 32)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        }
        topUpAccountButton.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            $0.heightAnchor.constraint(equalToConstant: 45)
        }
        
        headerContainer.addSubview(headerStackView)
        headerStackView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16)
            $0.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 32)
            $0.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        }
    }
}
