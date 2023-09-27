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
    
    public init(
        title: String,
        target: (Any?, Selector),
        color: UIColor = .black,
        loadingIndicatorColor: UIColor = .white
    ) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        activityLoader.color = loadingIndicatorColor
        addTarget(target.0, action: target.1, for: .touchUpInside)
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
}
