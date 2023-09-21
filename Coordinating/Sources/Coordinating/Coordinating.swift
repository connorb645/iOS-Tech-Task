//
//  Coordinator.swift
//  MoneyBox
//
//  Created by Connor Black on 21/09/2023.
//

import Foundation

public protocol Coordinating {
    var children: [Coordinating] { get set }
    var router: Routing { get set }
    
    func start(isAnimated: Bool, canGoBack: Bool)
}
