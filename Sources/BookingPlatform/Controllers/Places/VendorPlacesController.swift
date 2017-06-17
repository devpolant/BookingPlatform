//
//  VendorPlacesController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class VendorPlacesController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.post("/add", handler: self.addPlace)
    }
    
    
    /// Add place to vendor's locations
    func addPlace(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
}
