//
//  DataProviderMock.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import Foundation
import Networking

public final class DataProviderMock: DataProviderLogic {
    public init() {}
    public func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        StubData.read(file: "LoginSucceed", callback: completion)
    }
    
    public func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        StubData.read(file: "Accounts", callback: completion)
    }
    
    public func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        completion(.success(OneOffPaymentResponse(moneybox: 100.00)))
    }
}
