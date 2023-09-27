//
//  CountingAnimatedLabel.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import UIKit
import Core
import Foundation

public final class CountingAnimatedLabel: UILabel {
    private let formatAsCurrency: CurrencyFormatter
    
    private var endValue: Double?
    private var value: Double
    private var animationStartDate: Date
    
    private let animationDuration: Double
    
    public init(startValue: Double,
                animationDuration: Double = 2.0,
                formatAsCurrency: @escaping CurrencyFormatter) {
        self.formatAsCurrency = formatAsCurrency
        self.value = startValue
        self.animationStartDate = Date()
        self.animationDuration = animationDuration
        super.init(frame: .zero)
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateAmount(to amount: Double) {
        animationStartDate = Date()
        endValue = amount
    }
    
    @objc
    func handleUpdate(){
        guard let endValue else { return }
        
        let now = Date()
        let timeElapsed = now.timeIntervalSince(animationStartDate)
        
        if timeElapsed > animationDuration {
            text = self.formatAsCurrency(endValue)
            self.endValue = nil
            self.value = endValue
        } else {
            let percentage = timeElapsed / animationDuration
            let v = value + percentage * (endValue - value)
            text = self.formatAsCurrency(v)
        }
        
        HapticFeedback.impactOccurred()
    }
}
