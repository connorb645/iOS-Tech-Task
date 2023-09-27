//
//  RouterMock.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import UIKit
import Foundation
import Coordinating

public final class RouterMock: Routing {
    public struct PushInvocation: Equatable {
        public init(animated: Bool, canGoBack: Bool) {
            self.animated = animated
            self.canGoBack = canGoBack
        }
        public let animated: Bool
        public let canGoBack: Bool
    }
    
    public enum MethodCall: Equatable {
        case push(Input<PushInvocation>)
        case dismiss(Input<Bool>)
        case popToRoot(Input<Bool>)
        case present(Input<Bool>)
    }
    
    public var methodCalls: [MethodCall] = []
    
    public init() { }
    
    public func push(_ viewController: UIViewController, animated: Bool, canGoBack: Bool) {
        methodCalls.append(
            .push(
                Input(
                    PushInvocation(
                        animated: animated,
                        canGoBack: canGoBack
                    )
                )
            )
        )
    }
    
    public func dismiss(animated: Bool) {
        methodCalls.append(
            .dismiss(Input(animated))
        )
    }
    
    public func popToRoot(animated: Bool) {
        methodCalls.append(
            .popToRoot(Input(animated))
        )
    }
    
    public func present(_ viewController: UIViewController, animated: Bool) {
        methodCalls.append(
            .present(
                Input(
                    animated
                )
            )
        )
    }
    
    public func reset() {
        methodCalls.removeAll()
    }
}
