//
//  LoginView.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import Core
import UIKit

final class LoginView: View<LoginViewModel> {
    lazy var tempText: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func configureView() {
        super.configureView()
        addSubview(tempText)
        NSLayoutConstraint.activate([
            tempText.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
