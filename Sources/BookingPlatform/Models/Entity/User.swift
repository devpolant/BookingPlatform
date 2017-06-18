//
//  User.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

class User {
    
    var id: Int?
    var login: String
    var email: String
    var password: String
    var salt: String
    var token: AccessToken
    
    init(id: Int? = nil, login: String, email: String, password: String, salt: String, token: AccessToken) {
        self.id = id
        self.login = login
        self.email = email
        self.password = password
        self.salt = salt
        self.token = token
    }
}
