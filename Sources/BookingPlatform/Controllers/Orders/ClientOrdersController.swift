//
//  ClientOrdersController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Foundation
import Kitura

class ClientOrdersController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.all(middleware: AccessControlMiddleware())
        
        self.baseRouter.post("/create", handler: self.createOrder)
        self.baseRouter.post("/list", handler: self.ownOrders)
        self.baseRouter.post("/order_items", handler: self.orderItems)
    }
    
    // MARK: Orders
    
    /// Create order with location's places
    func createOrder(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        guard let token = request.token else { return }
        
        let requiredFields = ["location_id", "date_from", "date_to", "place_ids"]
        
        guard let fields = request.getPost(fields: requiredFields) else {
            try response.badRequest(expected: requiredFields).end()
            return
        }
        let locationId = Int(fields["location_id"]!)!
        let dateFrom = TimeInterval(fields["date_from"]!)!
        let dateTo = TimeInterval(fields["date_to"]!)!
        let placeIds = fields["place_ids"]!
            .components(separatedBy: ",")
            .flatMap { placeId in Int(placeId) }
        
        
        let (db, connection) = try MySQLConnector.connectToDatabase()
        
        guard let client = try DatabaseManager.shared.fetchClient(byToken: token, from: db, on: connection) else {
            return
        }
        guard let _ = try DatabaseManager.shared.location(with: locationId, from: db, on: connection) else {
            return
        }
        let order = Order(locationId: locationId, clientId: client.id!, dateTimeFrom: dateFrom, dateTimeTo: dateTo)
        do {
            try DatabaseManager.shared.addOrder(order, withPlaces: placeIds, to: db, connection: connection)
        } catch {
            let errorMessage = "Error while saving order"
            try response.internalServerError(message: errorMessage).end()
            return
        }
        
        let result: [String: Any] = [
            "error": false
        ]
        response.send(json: result)
    }
    
    
    /// List of client's orders
    func ownOrders(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        guard let token = request.token else { return }
        
        let (db, connection) = try MySQLConnector.connectToDatabase()
        guard let client = try DatabaseManager.shared.fetchClient(byToken: token, from: db, on: connection) else {
            return
        }
        
        let orders: [Order]
        do {
            orders = try DatabaseManager.shared.filterOrders(by: client, from: db, connection: connection)
        } catch {
            let errorMessage = "Error while fetching orders for client"
            try response.internalServerError(message: errorMessage).end()
            return
        }
        
        let result: [String: Any] = [
            "error": false,
            "orders": orders.map { $0.responseDictionary }
        ]
        response.send(json: result)
    }
    
    
    // MARK: Order Items
    
    /// List of order items for order with id
    func orderItems(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        // TODO: fetch order items
    }
}
