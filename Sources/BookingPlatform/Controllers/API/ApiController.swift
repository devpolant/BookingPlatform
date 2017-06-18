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
        
        rootRouter.post(middleware: self.parser)
        rootRouter.all("/static", middleware: self.fileServer)
        
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

// MARK: - Parser

extension ApiController {
    
    var parser: RouterMiddleware {
        return BodyParser()
    }
}

// MARK: - File Server

extension ApiController {
    
    var fileServer: RouterMiddleware {
        return StaticFileServer()
    }
}
