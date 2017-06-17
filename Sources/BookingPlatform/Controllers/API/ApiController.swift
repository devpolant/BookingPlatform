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
        
        // Routers
        let authRouter = rootRouter.route("/auth")
        let locationsRouter = rootRouter.route("/location")
        let placesRouter = rootRouter.route("/places")
        let ordersRouter = rootRouter.route("/orders")
        
        // Controllers
        let authController = AuthController(baseRouter: authRouter)
        let locationsController = LocationsController(baseRouter: locationsRouter)
        let placesController = PlacesController(baseRouter: placesRouter)
        let ordersController = OrdersController(baseRouter: ordersRouter)
        
        let controllers: [RouteRepresentable] = [
            authController,
            locationsController,
            placesController,
            ordersController
        ]
        controllers.forEach { $0.setupRoutes() }
        
        return rootRouter
    }()
}
