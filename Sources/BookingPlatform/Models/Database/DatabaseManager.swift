//
//  DatabaseManager.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import MySQL

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private init() {}
    
    
    // MARK: - Client
    
    // MARK: CRUD
    
    func addClient(_ client: Client, to db: Database, on connection: Connection) throws -> Int {
        let query = "INSERT INTO `clients` (login, email, password, salt, token) VALUES (?, ?, ?, ?, ?)"
        let arguments = [client.login, client.email, client.password, client.salt, client.token]
        // insert
        try db.execute(query, arguments, connection)
        // fetch id
        return try self.fetchClient(byToken: client.token, from: db, on: connection)!.id!
    }
    
    func updateClient(_ client: Client, in db: Database, on connection: Connection) throws {
        guard let id = client.id else {
            return
        }
        let query = "UPDATE `clients` SET `login` = ?, `email` = ?, `password` = ?, `salt` = ?, `token` = ? WHERE `id` = ?"
        let arguments: [NodeRepresentable] = [client.login, client.email, client.password, client.salt, client.token, id]
        try db.execute(query, arguments, connection)
    }
    
    // MARK: Fetch
    
    func fetchClient(byEmail email: String, from db: Database, on connection: Connection) throws -> Client? {
        let query = "SELECT * FROM `clients` WHERE `email` = ?;"
        let arguments: [NodeRepresentable] = [email]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Client(with: row)
    }
    
    func fetchClient(byToken token: String, from db: Database, on connection: Connection) throws -> Client? {
        let query = "SELECT * FROM `clients` WHERE `token` = ?;"
        let arguments: [NodeRepresentable] = [token]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Client(with: row)
    }
    
    
    // MARK: - Vendor
    
    // MARK: CRUD
    
    func addVendor(_ vendor: Vendor, to db: Database, on connection: Connection) throws -> Int {
        let query = "INSERT INTO `vendors` (login, email, password, salt, token) VALUES (?, ?, ?, ?, ?)"
        let arguments = [vendor.login, vendor.email, vendor.password, vendor.salt, vendor.token]
        // insert
        try db.execute(query, arguments, connection)
        // fetch id
        return try self.fetchVendor(byToken: vendor.token, from: db, on: connection)!.id!
    }
    
    func updateVendor(_ vendor: Vendor, in db: Database, on connection: Connection) throws {
        guard let id = vendor.id else {
            return
        }
        let query = "UPDATE `vendors` SET `login` = ?, `email` = ?, `password` = ?, `salt` = ?, `token` = ? WHERE `id` = ?"
        let arguments: [NodeRepresentable] = [vendor.login, vendor.email, vendor.password, vendor.salt, vendor.token, id]
        try db.execute(query, arguments, connection)
    }
    
    // MARK: Fetch
    
    func fetchVendor(byEmail email: String, from db: Database, on connection: Connection) throws -> Vendor? {
        let query = "SELECT * FROM `vendors` WHERE `email` = ?;"
        let arguments: [NodeRepresentable] = [email]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Vendor(with: row)
    }
    
    func fetchVendor(byToken token: String, from db: Database, on connection: Connection) throws -> Vendor? {
        let query = "SELECT * FROM `vendors` WHERE `token` = ?;"
        let arguments: [NodeRepresentable] = [token]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Vendor(with: row)
    }
    
    func fetchVendor(byId id: Int, from db: Database, on connection: Connection) throws -> Vendor? {
        let query = "SELECT * FROM `vendors` WHERE `id` = ?;"
        let arguments: [NodeRepresentable] = [id]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Vendor(with: row)
    }
    
    
    // MARK: - Locations
    
    // MARK: CRUD
    
    func addLocation(_ location: Location, to db: Database, on connection: Connection) throws {
        let query = "INSERT INTO `locations` (vendor_id, name, lat, lng) VALUES (?, ?, ?, ?)"
        let arguments: [NodeRepresentable] = [
            location.vendorId, location.name, location.coordinate.latitude, location.coordinate.longitude
        ]
        try db.execute(query, arguments, connection)
    }
    
    
    // MARK: Fetch
    
    func allLocations(from db: Database, on connection: Connection) throws -> [Location] {
        let query = "SELECT * from `locations`"
        let arguments: [NodeRepresentable] = []
        let rows = try db.execute(query, arguments, connection)
        return rows.map {
            Location(with: $0)
        }
    }
    
    func filterLocations(by vendor: Vendor, from db: Database, on connection: Connection) throws -> [Location] {
        guard let id = vendor.id else {
            return []
        }
        let query = "SELECT * from `locations` WHERE `vendor_id` = ?"
        let arguments: [NodeRepresentable] = [id]
        let rows = try db.execute(query, arguments, connection)
        return rows.map {
            Location(with: $0)
        }
    }
    
    func location(with id: Int, from db: Database, on connection: Connection) throws -> Location? {
        let query = "SELECT * from `locations` WHERE `id` = ?"
        let arguments: [NodeRepresentable] = [id]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Location(with: row)
    }
    
    
    // MARK: - Places
    
    // MARK: CRUD
    
    func addPlace(_ place: Place, to db: Database, on connection: Connection) throws {
        let query = "INSERT INTO `places` (location_id, place_number) VALUES (?, ?)"
        let arguments: [NodeRepresentable] = [
            place.locationId, place.number
        ]
        try db.execute(query, arguments, connection)
    }
    
    // MARK: Fetch
    
    func filterPlaces(byLocation location: Location, from db: Database, on connection: Connection) throws -> [Place] {
        guard let id = location.id else {
            return []
        }
        let query = "SELECT * from `places` WHERE `location_id` = ?"
        let arguments: [NodeRepresentable] = [id]
        let rows = try db.execute(query, arguments, connection)
        return rows.map {
            Place(with: $0)
        }
    }
    
    
    // MARK: - Orders
    
    // MARK: CRUD
    
    func addOrder(_ order: Order, withPlaces placeIds: [Int], to db: Database, connection: Connection) throws {
        
        let orderQuery = "INSERT INTO `orders` (location_id, client_id, date_from, date_to) VALUES (?, ?, ?, ?)"
        let orderArguments: [NodeRepresentable] = [
            order.locationId, order.clientId, order.dateFrom.timeIntervalSince1970, order.dateTo.timeIntervalSince1970
        ]
        do {
            try db.beginTransaction(connection: connection)
            
            try db.execute(orderQuery, orderArguments, connection)
            
            let idQuery = "SELECT MAX(id) AS `identifier` from `orders` where `client_id` = ?"
            let idArguments: [NodeRepresentable] = [order.clientId]
            let idRows = try db.execute(idQuery, idArguments, connection)
            guard let orderId = idRows.first?["identifier"]?.int else {
                try db.rollbackTransaction(connection: connection)
                return
            }
            let orderItems = placeIds.map { placeId in OrderItem(orderId: orderId, placeId: placeId) }
            
            try orderItems.forEach {
                try self.addOrderItem($0, to: db, connection: connection)
            }
            try db.commitTransaction(connection: connection)
            
        } catch {
            try db.rollbackTransaction(connection: connection)
            throw error
        }
    }
    
    private func addOrderItem(_ orderItem: OrderItem, to db: Database, connection: Connection) throws {
        let query = "INSERT INTO `order_items` (order_id, place_id) VALUES (?, ?)"
        let arguments: [NodeRepresentable] = [
            orderItem.orderId, orderItem.placeId
        ]
        try db.execute(query, arguments, connection)
    }
    
    // MARK: Fetch
    
    func filterOrders(by client: Client, from db: Database, connection: Connection) throws -> [Order] {
        guard let id = client.id else {
            return []
        }
        let query = "SELECT * from `orders` WHERE `client_id` = ?"
        let arguments: [NodeRepresentable] = [id]
        let rows = try db.execute(query, arguments, connection)
        return rows.map {
            Order(with: $0)
        }
    }
}
