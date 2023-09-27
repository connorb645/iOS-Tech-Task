//
//  HapticFeedback.swift
//  
//
//  Created by Connor Black on 28/09/2023.
//

import Foundation
import UIKit

public struct HapticFeedback {
    static public func impactOccurred(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
