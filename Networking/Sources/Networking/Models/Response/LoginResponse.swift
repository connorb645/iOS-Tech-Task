//
//  LoginResponse.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import Foundation

// MARK: - LoginResponse
public struct LoginResponse: Decodable, Equatable {
    public let session: Session
    public let user: User
    
    public init(session: Session, user: User) {
        self.session = session
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        case session = "Session"
        case user = "User"
    }
    
    public struct Session: Decodable, Equatable {
        public let bearerToken: String
        
        public init(bearerToken: String) {
            self.bearerToken = bearerToken
        }
        
        enum CodingKeys: String, CodingKey {
            case bearerToken = "BearerToken"
        }
    }
    
    // MARK: - User
    public struct User: Codable, Equatable {
        public let firstName: String?
        public let lastName: String?
        
        public init(firstName: String?, lastName: String?) {
            self.firstName = firstName
            self.lastName = lastName
        }
        
        enum CodingKeys: String, CodingKey {
            case firstName = "FirstName"
            case lastName = "LastName"
        }
    }
}
