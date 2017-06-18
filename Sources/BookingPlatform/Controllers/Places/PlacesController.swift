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
        self.baseRouter.all(middleware: AccessControlMiddleware())
        
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
        
        let requiredFields = ["location_id"]
        guard let fields = request.getPost(fields: requiredFields) else {
            try response.badRequest(expected: requiredFields).end()
            return
        }
        let locationId = Int(fields["location_id"]!)!
        let (db, connection) = try MySQLConnector.connectToDatabase()
        
        guard let location = try DatabaseManager.shared.location(with: locationId, from: db, on: connection) else {
            let errorMessage = "Location not found"
            try response.internalServerError(message: errorMessage).end()
            return
        }
        
        let places: [Place]
        do {
            places = try DatabaseManager.shared.filterPlaces(byLocation: location, from: db, on: connection)
        } catch {
            let errorMessage = "Error while fetching places"
            try response.internalServerError(message: errorMessage).end()
            return
        }
        
        let result: [String: Any] = [
            "error": false,
            "places": places.map { $0.responseDictionary }
        ]
        response.send(json: result)
    }
}
