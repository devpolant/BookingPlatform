//
//  VendorAuthController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class VendorAuthController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.post("/signup", handler: self.signUp)
        self.baseRouter.post("/login", handler: self.login)
    }
    
    // MARK: Auth
    
    func signUp(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
    
    func login(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
}
