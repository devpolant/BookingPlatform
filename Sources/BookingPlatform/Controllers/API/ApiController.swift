//
//  ApiController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class ApiController {
    
    /// Composition root
    lazy var router: Router = {
        
        let rootRouter = Router()
        
        let authRouter = rootRouter.route("/auth")
        
        let authController = AuthController(baseRouter: authRouter)
        
        let controllers: [RouteRepresentable] = [
            authController
        ]
        controllers.forEach { $0.setupRoutes() }
        
        return rootRouter
    }()
}
