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
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(accountTitleLabel)
        view.addArrangedSubview(productTitleLabel)
        return view
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.productTitle
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.textColor = .white
        return label
    }()
    
    private lazy var accountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.accountTitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var planValueInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "This plans value is:"
        return label
    }()
    
    private lazy var planValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .black)
        label.text = viewModel.formatAsCurrency(viewModel.planValue)
        return label
    }()
    
    private lazy var moneyboxInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "The value in your moneybox is:"
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
        return label
    }()
    
    private lazy var detailContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(moneyboxInfoLabel)
        stackView.addArrangedSubview(moneyboxLabel)
        stackView.addArrangedSubview(planValueInfoLabel)
        stackView.addArrangedSubview(planValueLabel)
        return stackView
    }()
    
    private lazy var topUpAccountButton: PrimaryButton = {
        let button = PrimaryButton(
            title: viewModel.formatAsCurrency(Double(viewModel.topUpAmount)),
            target: (self, #selector(topUpAccountButtonTapped))
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
            $0.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 64)
            $0.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        }
    }
}
