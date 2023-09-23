//
//  ProductDetailViewController.swift
//  
//
//  Created by Connor Black on 24/09/2023.
//

import Foundation
import Core

final public class ProductDetailViewController: ViewController<ProductDetailViewModel, ProductDetailView> {
    let viewModel: ProductDetailViewModel
    public init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(
            view: ProductDetailView(
                viewModel: viewModel
            )
        )
    }
}
