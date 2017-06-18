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
        
        guard let token = request.token else {
            return
        }
        let (db, connection) = try MySQLConnector.connectToDatabase()
        
        guard let vendor = try DatabaseManager.shared.fetchVendor(byToken: token, from: db, on: connection) else {
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
    
    /// Add location to vendor
    func addLocation(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        guard let token = request.token else { return }
        
        let requiredFields = ["name", "latitude", "longitude"]
        guard let fields = request.getPost(fields: requiredFields) else {
            try response.badRequest(expected: requiredFields).end()
            return
        }
        let name = fields["name"]!
        let latitude = Double(fields["latitude"]!)!
        let longitude = Double(fields["longitude"]!)!
        
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
        
        let (db, connection) = try MySQLConnector.connectToDatabase()
        
        guard let vendor = try DatabaseManager.shared.fetchVendor(byToken: token, from: db, on: connection) else {
            let errorMessage = "Vendor not found"
            _ = response.badRequest(message: errorMessage)
            return
        }
        
        let location = Location(name: name, coordinate: coordinate, vendorId: vendor.id!)
        do {
            try DatabaseManager.shared.addLocation(location, to: db, on: connection)
        } catch {
            let errorMessage = "Error while loading inserting location to database"
            _ = response.internalServerError(message: errorMessage)
            return
        }
        let result: [String: Any] = [
            "error": false
        ]
        response.send(json: result)
    }
}
