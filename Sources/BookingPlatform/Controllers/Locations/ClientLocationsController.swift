//
//  ClientLocationsController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class ClientLocationsController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.post("/all", handler: self.locations)
        self.baseRouter.post("/vendor", handler: self.locationsByVendor)
    }
    
    
    /// All locations
    func locations(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
    
    /// Locations by vendor identifier
    func locationsByVendor(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
}
