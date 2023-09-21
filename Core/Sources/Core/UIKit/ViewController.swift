//
//  ViewController.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import UIKit

/**
 ViewController is a generic UIViewController subclass that manages a View.
 
 - Parameters:
 - VM: The ViewModel type for the View.
 - V:  The View type managed by the ViewController.
 
 ## Overview
 
 ViewController handles instantiating and configuring a View, binding it to the
 view hierarchy.
 
 ViewController handles basic view setup like background color, adding the
 view as a subview, and pinning it to the edges via layout constraints.
 
 ## Usage
 
 To use ViewController:
 
 1. Create a ViewModel and View type for the screen.
 2. Subclass ViewController with the VM and V types.
 3. Instantiate the ViewController subclass passing in the View instance.
 4. Customize the ViewModel and View implementations as needed.
 */
open class ViewController<VM: ViewModel, V: View<VM>>: UIViewController {
    private let baseView: V
    
    public init(view: V) {
        self.baseView = view
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseView()
    }
    
    private func configureBaseView() {
        view.backgroundColor = .white
        view.addSubview(baseView)
        
        baseView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            $0.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
            $0.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        }
        
        view.layoutIfNeeded()
    }
}
