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
        view.backgroundColor = .blue
        view.addSubview(title)
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.layoutIfNeeded()
        return label
    }()
    
    private lazy var topUpAccountButton: PrimaryButton = {
        let button = PrimaryButton(
            title: "Add £\(topUpFixedAmount)",
            target: (self, #selector(topUpAccountButtonTapped))
        )
        return button
    }()
    
    private let topUpFixedAmount = 10
    
    override init(viewModel: ProductDetailViewModel) {
        super.init(viewModel: viewModel)
        bindViewModelActions()
    }
    
    private func bindViewModelActions() {
        
    }
    
    @objc
    private func topUpAccountButtonTapped() {
        viewModel.addOneOffPayment(of: topUpFixedAmount)
    }

    public override func configureView() {
        super.configureView()
        addSubview(headerContainer)
        addSubview(topUpAccountButton)
        headerContainer.activateConstraints {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
        }
        topUpAccountButton.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            $0.heightAnchor.constraint(equalToConstant: 45)
        }
        
        headerContainer.addSubview(title)
        title.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16)
            $0.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 64)
            $0.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        }
    }
}
