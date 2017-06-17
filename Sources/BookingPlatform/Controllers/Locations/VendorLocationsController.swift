//
//  VendorLocationsController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class VendorLocationsController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.post("/list", handler: self.ownLocations)
        self.baseRouter.post("/add", handler: self.addLocation)
    }
    
    
    /// Vendor's locations by token
    func ownLocations(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
    
    /// Add location to vendor
    func addLocation(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
}
