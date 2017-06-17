//
//  PlacesController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class PlacesController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        
        // common routes for vendor and client
        self.baseRouter.post("/list", handler: self.availablePlaces)
        
        // specific routes
        let clientRouter = self.baseRouter.route("/client")
        let vendorRouter = self.baseRouter.route("/vendor")
        
        let clientPlacesController = ClientPlacesController(baseRouter: clientRouter)
        let vendorPlacesController = VendorPlacesController(baseRouter: vendorRouter)
        
        let controllers: [RouteRepresentable] = [
            clientPlacesController,
            vendorPlacesController
        ]
        controllers.forEach { $0.setupRoutes() }
    }
    
    
    /// List of places by location id
    func availablePlaces(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        
    }
}
