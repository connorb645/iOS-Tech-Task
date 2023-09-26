//
//  UIViewConstraintsExtensionTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import Foundation
import XCTest
@testable import Core

final class UIViewConstraintsExtensionTests: XCTestCase {
    
    func test_activateConstraints() {
        let view = UIView()
        let superView = UIView()
        
        superView.addSubview(view)
        
        view.activateConstraints { v in
            [
                v.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: superView.trailingAnchor)
            ]
        }
        
        XCTAssertEqual(view.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertTrue(superView.constraints.contains { $0.firstAttribute == .leading && $0.isActive })
        XCTAssertTrue(superView.constraints.contains { $0.firstAttribute == .trailing && $0.isActive })
    }
    
    func test_activateConstraintsWithEither() {
        let view = UIView()
        let superView = UIView()
        
        superView.addSubview(view)
        
        let useFirstSet = true
        
        view.activateConstraints { v in
            if useFirstSet {
                return [
                    v.leadingAnchor.constraint(equalTo: superView.leadingAnchor)
                ]
            } else {
                return [
                    v.trailingAnchor.constraint(equalTo: superView.trailingAnchor)
                ]
            }
        }
        
        XCTAssertEqual(view.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertTrue(superView.constraints.contains { $0.firstAttribute == .leading && $0.isActive })
        XCTAssertFalse(superView.constraints.contains { $0.firstAttribute == .trailing && $0.isActive })
    }
}
