//
//  OneOffPaymentResponse.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 18.01.2022.
//

import Foundation

public struct OneOffPaymentResponse: Decodable, Equatable {
    public let moneybox: Double?
    
    public init(moneybox: Double?) {
        self.moneybox = moneybox
    }
    
    enum CodingKeys: String, CodingKey {
        case moneybox = "Moneybox"
    }
}
