//
//  PrimaryButton.swift
//  
//
//  Created by Connor Black on 23/09/2023.
//

import Foundation
import UIKit
import Core

public final class PrimaryButton: UIButton {
    
    public var isLoading: Bool = false {
        didSet {
            if isLoading {
                activityLoader.startAnimating()
                titleLabel?.alpha = 0.0
                isEnabled = false
            } else {
                activityLoader.stopAnimating()
                titleLabel?.alpha = 1.0
                isEnabled = true
            }
        }
    }
    
    private lazy var activityLoader: UIActivityIndicatorView = {
        let activityLoader = UIActivityIndicatorView()
        activityLoader.hidesWhenStopped = true
        return activityLoader
    }()
    
    private let action: () -> Void
    
    public init(
        title: String,
        color: UIColor = .black,
        loadingIndicatorColor: UIColor = .white,
        action: @escaping () -> Void
    ) {
        self.action = action
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        activityLoader.color = loadingIndicatorColor
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
        addActivityLoader()
    }
    
    private func addActivityLoader() {
        addSubview(activityLoader)
        activityLoader.activateConstraints {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func tapped() {
        HapticFeedback.impactOccurred()
        action()
    }
}
