//
//  View.swift
//  
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation
import UIKit

/**
 View is a generic UIView subclass that is configured with a ViewModel.

 - Parameter VM: The ViewModel type for this View.

 ## Overview

 View enforces setting a ViewModel instance during initialization. This allows
 separating view state and logic from the view layer.

 Subclasses should implement configureView() to setup the specific view contents.

 ## Usage

 To use View:

 1. Create a ViewModel subclass for the screen.
 2. Subclass View with the VM type.
 3. Override configureView() to customize the view.
 4. Initialize the View subclass passing in the ViewModel.
 */
open class View<VM: ViewModel>: UIView {
    public let viewModel: VM
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureView()
    }
    
    @available(*, unavailable)
    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureView() {}
}
