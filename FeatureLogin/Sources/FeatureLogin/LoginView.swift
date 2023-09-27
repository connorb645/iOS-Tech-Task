//
//  LoginView.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Core
import UIKit
import CoreUI
import Foundation

final class LoginView: View<LoginViewModel> {
    private func textFieldHeaderLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        return label
    }
    
    private lazy var moneyboxImage: UIImageView = {
        let image = UIImage(named: "moneybox", in: viewModel.bundle, with: .none)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e.g. example@gmail.com"
        #if DEBUG
        textField.text = "test+ios2@moneyboxapp.com"
        #endif
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        #if DEBUG
        textField.text = "P455word12"
        #endif
        return textField
    }()
    
    private lazy var emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(textFieldHeaderLabel("Email Address"))
        stackView.addArrangedSubview(emailTextField)
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(textFieldHeaderLabel("Password"))
        stackView.addArrangedSubview(passwordTextField)
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton(
            title: "Login",
            target: (self,  #selector(loginTapped))
        )
        button.activateConstraints {
            $0.heightAnchor.constraint(equalToConstant: 45)
        }
        return button
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(moneyboxImage)
        stackView.addArrangedSubview(emailStackView)
        stackView.addArrangedSubview(passwordStackView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(errorLabel)
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.0
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(viewModel: LoginViewModel) {
        super.init(viewModel: viewModel)
        bindViewModelActions()
    }
    
    private func bindViewModelActions() {
        viewModel.setError = { [weak self] error in
            guard let self else { return }
            if let error {
                errorLabel.text = error
                errorLabel.alpha = 1.0
            } else {
                errorLabel.text = error
                errorLabel.alpha = 0.0
            }
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
        
        viewModel.setIsLoading = { [weak self] visible in
            guard let self else { return }
            loginButton.isLoading = visible
        }
    }
    
    override func configureView() {
        super.configureView()
        
        addSubview(contentStackView)
        
        contentStackView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            $0.topAnchor.constraint(equalTo: topAnchor)
        }
    }
    
    @objc
    private func loginTapped() {
        viewModel.attemptLogin(
            with: .init(
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? ""
            )
        )
    }
}
