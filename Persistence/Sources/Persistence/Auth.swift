//
//  Auth.swift
//  
//
//  Created by Connor Black on 22/09/2023.
//

import Foundation

public struct Auth {
    public static let shared: Auth = .init()
    
    private let key = "auth_token_key"
    
    private let userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    public func setAuthToken(to token: String) {
        userDefaults.set(token, forKey: key)
    }
    
    public func getAuthToken() -> String? {
        userDefaults.string(forKey: key)
    }
    
    public func clearAuthToken() {
        userDefaults.set(nil, forKey: key)
    }
}
