//
//  AuthMiddleware.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class AccessControlMiddleware: RouterMiddleware {
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        
        guard request.hasToken else {
            try response.end()
            return
        }
        next()
    }
}
