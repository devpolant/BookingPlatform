//
//  AuthController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class AuthController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Setup
    
    func setupRoutes() {
        
        let clientRouter = self.baseRouter.route("/client")
        let vendorRouter = self.baseRouter.route("/vendor")
        
        let clientController = ClientAuthController(baseRouter: clientRouter)
        let vendorController = VendorAuthController(baseRouter: vendorRouter)
        
        let controllers: [RouteRepresentable] = [
            clientController,
            vendorController
        ]
        controllers.forEach { $0.setupRoutes() }
    }
    
}

