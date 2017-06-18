//
//  VendorOrdersController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class VendorOrdersController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.all(middleware: AccessControlMiddleware())
        self.baseRouter.post("/list", handler: self.bookedOrders)
    }
    
    // MARK: Orders
    
    /// list of orders for selected location
    func bookedOrders(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        // TODO: fetch booked orders
    }
}
