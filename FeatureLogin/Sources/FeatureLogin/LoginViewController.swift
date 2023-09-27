//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import Core
import UIKit

final class LoginViewController: ViewController<LoginViewModel, LoginView> {
    init(viewModel: LoginViewModel) {
        super.init(
            view: LoginView(
                viewModel: viewModel
            )
        )
        view.backgroundColor = viewModel.theme.background
    }
}
