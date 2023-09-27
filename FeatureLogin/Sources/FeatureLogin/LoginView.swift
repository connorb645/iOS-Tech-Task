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
        label.textColor = viewModel.theme.font
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
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.borderStyle = .roundedRect
        textField.textColor = viewModel.theme.font
        textField.backgroundColor = viewModel.theme.backgroundOffset
        textField.tintColor = viewModel.theme.font
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.textColor = viewModel.theme.font
        textField.backgroundColor = viewModel.theme.backgroundOffset
        textField.tintColor = viewModel.theme.font
        textField.textContentType = .password
        textField.returnKeyType = .go
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
            color: viewModel.theme.accentColour
        ) { [weak self] in
            self?.loginTapped()
        }
        button.activateConstraints {
            $0.heightAnchor.constraint(equalToConstant: 45)
        }
        return button
    }()
    
    private lazy var stackViewContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
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
        label.textColor = .red
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(contentStackView)
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        return scrollView
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
        
        addSubview(scrollView)
        scrollView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        
        scrollView.addSubview(contentStackView)
        contentStackView.activateConstraints {
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor)
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            $0.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, multiplier: 0.9)
        }
        
        emailTextField.activateConstraints {
            $0.heightAnchor.constraint(equalToConstant: 45)
        }
        
        passwordTextField.activateConstraints {
            $0.heightAnchor.constraint(equalToConstant: 45)
        }
    }
    
    private func loginTapped() {
        viewModel.attemptLogin(
            with: .init(
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? ""
            )
        )
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            HapticFeedback.impactOccurred()
            loginTapped()
        }
        return true
    }
}
