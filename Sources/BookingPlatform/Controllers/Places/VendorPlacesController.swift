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
        
        guard let token = request.token else { return }
        
        let requiredFields = ["location_id", "place_number"]
        guard let fields = request.getPost(fields: requiredFields) else {
            try response.badRequest(expected: requiredFields).end()
            return
        }
        let locationId = Int(fields["location_id"]!)!
        let placeNumber = Int(fields["place_number"]!)!
        
        let (db, connection) = try MySQLConnector.connectToDatabase()
        
        // validation
        guard let _ = try DatabaseManager.shared.fetchVendor(byToken: token, from: db, on: connection) else {
            let errorMessage = "Vendor not found"
            _ = response.badRequest(message: errorMessage)
            return
        }
        guard let _ = try DatabaseManager.shared.location(with: locationId, from: db, on: connection) else {
            let errorMessage = "Location not found"
            _ = response.badRequest(message: errorMessage)
            return
        }
        
        let place = Place(locationId: locationId, number: placeNumber)
        do {
            try DatabaseManager.shared.addPlace(place, to: db, on: connection)
        } catch {
            let errorMessage = "Error while inserting place to database"
            _ = response.internalServerError(message: errorMessage)
            return
        }
        let result: [String: Any] = [
            "error": false
        ]
        response.send(json: result)
    }
}
