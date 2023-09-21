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
    private func textFieldHeaderLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        return label
    }
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        // TODO: - Add resultBuilder for adding arranged subviews to stackviews
        stackView.addArrangedSubview(textFieldHeaderLabel("Accounts List View"))
        stackView.addArrangedSubview(logoutButton)
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    public override func configureView() {
        super.configureView()
        
        scrollView.addSubview(contentStackView)
        addSubview(scrollView)
        
        scrollView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.rightAnchor.constraint(equalTo: rightAnchor)
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        
        contentStackView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor)
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        }
    }
    
    @objc
    private func logoutTapped() {
        viewModel.logout()
    }
}
