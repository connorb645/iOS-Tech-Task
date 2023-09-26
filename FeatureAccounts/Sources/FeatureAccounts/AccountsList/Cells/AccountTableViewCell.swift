//
//  AccountTableViewCell.swift
//  
//
//  Created by Connor Black on 23/09/2023.
//

import Foundation
import UIKit
import Core

final class AccountTableViewCell: UITableViewCell, ReuseIdentifiable {
    struct CellConfigurationData {
        let accountWrapperId: String?
        let title: String?
        let planValue: Double?
        let earningsNet: Double?
        let earningsPercentage: Double?
        let products: [ProductCollectionViewCell.CellConfigurationData]
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    lazy var productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private let collectionViewHeight: Double = 200
    
    private var cellConfigurationData: CellConfigurationData?
    var didTapProduct: ((Int, String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.removeFromSuperview()
        productsCollectionView.removeFromSuperview()
    }
    
    func configure(with data: CellConfigurationData) {
        cellConfigurationData = data
        setupConstraints()
        titleLabel.text = data.title ?? ""
        productsCollectionView.reloadData()
    }
    
    private func setupConstraints() {
        contentView.addSubview(containerView)
        
        containerView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        }
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(productsCollectionView)
        
        titleLabel.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            $0.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8)
            $0.bottomAnchor.constraint(equalTo: productsCollectionView.topAnchor, constant: -8)
        }

        productsCollectionView.activateConstraints {
            $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0)
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
            $0.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            $0.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = self.cellConfigurationData?.products[safe: indexPath.row]?.id,
              let accountWrapperId = self.cellConfigurationData?.accountWrapperId else { return }
        didTapProduct?(productId, accountWrapperId)
    }
}

extension AccountTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 300, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension AccountTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellConfigurationData?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell,
                let product = cellConfigurationData?.products[safe: indexPath.row] else {
            fatalError("Unable to deque \(AccountTableViewCell.reuseIdentifier)")
        }
        cell.configure(with: product)
        return cell
    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let cell = cell as? ProductCollectionViewCell,
//              let product = cellConfigurationData?.products[safe: indexPath.row] else { return }
//        cell.configure(with: product)
//    }
}
