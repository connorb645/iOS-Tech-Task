//
//  SessionManager.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 18.07.2022.
//

import Foundation

public protocol SessionManagerType {
    func setUserToken(_ token: String)
    func removeUserToken()
}

final public class SessionManager: NSObject, SessionManagerType {
    public func setUserToken(_ token: String) {
        Authentication.token = token
    }
    
    public func removeUserToken() {
        Authentication.token = nil
    }
}
