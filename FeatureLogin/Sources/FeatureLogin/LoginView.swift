//
//  LoginView.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Core
import UIKit
import Foundation

final class LoginView: View<LoginViewModel> {
    lazy var tempText: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        return label
    }()
    
    override func configureView() {
        super.configureView()
        addSubview(tempText)
        tempText.activateConstraints {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
        }
    }
}
