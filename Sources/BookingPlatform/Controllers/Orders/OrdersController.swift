//
//  OrdersController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class OrdersController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.all(middleware: AccessControlMiddleware())
        
        let clientRouter = self.baseRouter.route("/client")
        let vendorRouter = self.baseRouter.route("/vendor")
        
        let clientOrdersController = ClientOrdersController(baseRouter: clientRouter)
        let vendorOrdersController = VendorOrdersController(baseRouter: vendorRouter)
        
        let controllers: [RouteRepresentable] = [
            clientOrdersController,
            vendorOrdersController
        ]
        controllers.forEach { $0.setupRoutes() }
    }
}
