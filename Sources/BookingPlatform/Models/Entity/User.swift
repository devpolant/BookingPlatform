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
    var name: String
    var email: String?
    var password: String
    var salt: String
    var token: AccessToken
    
    init(id: Int? = nil, login: String, name: String, email: String, password: String, salt: String, token: AccessToken) {
        self.id = id
        self.login = login
        self.name = name
        self.email = email
        self.password = password
        self.salt = salt
        self.token = token
    }
}
