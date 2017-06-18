//
//  Request+User.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

typealias AccessToken = String

extension RouterRequest {
    var token: AccessToken? {
        return getField(key: "token")
    }
    var hasToken: Bool {
        return self.token != nil
    }
}
