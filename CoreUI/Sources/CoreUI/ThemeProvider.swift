//
//  ThemeProvider.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import Foundation
import UIKit

public protocol ThemeProvider {
    var accentColour: UIColor { get }
    var background: UIColor { get }
    var backgroundOffset: UIColor { get }
    var font: UIColor { get }
}

public struct DefaultTheme: ThemeProvider {
    public var accentColour: UIColor
    public var background: UIColor
    public var backgroundOffset: UIColor
    public var font: UIColor
    
    public init(bundle: Bundle) {
        accentColour = UIColor(named: "AccentColor", in: bundle, compatibleWith: nil) ?? .blue
        background = UIColor(named: "BackgroundColor", in: bundle, compatibleWith: nil) ?? .white
        backgroundOffset = UIColor(named: "BackgroundOffsetColor", in: bundle, compatibleWith: nil) ?? .lightGray
        font = UIColor(named: "FontColor", in: bundle, compatibleWith: nil) ?? .black
    }
}
