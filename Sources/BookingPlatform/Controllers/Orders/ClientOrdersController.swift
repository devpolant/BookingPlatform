//
//  ClientOrdersController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class ClientOrdersController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.post("/create", handler: self.createOrder)
        self.baseRouter.post("/list", handler: self.ownOrders)
        self.baseRouter.post("/order_items", handler: self.orderItems)
    }
    
    // MARK: Orders
    
    /// Create order with location's places
    func createOrder(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
    
    
    /// List of client's orders
    func ownOrders(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
    
    // MARK: Order Items
    
    /// List of order items for order with id
    func orderItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
}
