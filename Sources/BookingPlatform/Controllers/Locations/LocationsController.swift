//
//  LocationsController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class LocationsController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        
        let clientRouter = self.baseRouter.route("/client")
        let vendorRouter = self.baseRouter.route("/vendor")
        
        let clientLocationsController = ClientLocationsController(baseRouter: clientRouter)
        let vendorLocationsController = VendorLocationsController(baseRouter: vendorRouter)
        
        let controllers: [RouteRepresentable] = [
            clientLocationsController,
            vendorLocationsController
        ]
        controllers.forEach { $0.setupRoutes() }
    }
}
