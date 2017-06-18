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
        
        let (db, connection) = try MySQLConnector.connectToDatabase()
        let locations: [Location]
        do {
            locations = try DatabaseManager.shared.allLocations(from: db, on: connection)
        } catch {
            let errorMessage = "Error while loading locations from database"
            _ = response.internalServerError(message: errorMessage)
            return
        }
        
        let result: [String: Any] = [
            "error": false,
            "locations": locations.map { $0.responseDictionary }
        ]
        response.send(json: result)
    }
    
    /// Locations by vendor identifier
    func locationsByVendor(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        let requiredFields = ["vendor_id"]
        guard let fields = request.getPost(fields: requiredFields) else {
            try response.badRequest(expected: requiredFields).end()
            return
        }
        let (db, connection) = try MySQLConnector.connectToDatabase()
        
        let vendorId = Int(fields["vendor_id"]!)!
        
        guard let vendor = try DatabaseManager.shared.fetchVendor(byId: vendorId, from: db, on: connection) else {
            let errorMessage = "Vendor not found"
            _ = response.badRequest(message: errorMessage)
            return
        }
        
        let locations: [Location]
        do {
            locations = try DatabaseManager.shared.filterLocations(by: vendor, from: db, on: connection)
        } catch {
            let errorMessage = "Error while loading locations from database"
            _ = response.internalServerError(message: errorMessage)
            return
        }
        
        let result: [String: Any] = [
            "error": false,
            "locations": locations.map { $0.responseDictionary }
        ]
        response.send(json: result)
    }
}
