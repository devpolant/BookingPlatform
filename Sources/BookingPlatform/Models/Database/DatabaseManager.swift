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
        let query = "INSERT INTO `clients` (login, name, email, password, salt, token) VALUES (?, ?, ?, ?, ?, ?)"
        let arguments = [client.login, client.name, client.email, client.password, client.salt, client.token]
        // insert
        try db.execute(query, arguments, connection)
        // fetch id
        return try self.fetchClient(by: client.email, from: db, on: connection)!.id!
    }
    
    func updateClient(_ client: Client, in db: Database, on connection: Connection) throws {
        guard let id = client.id else {
            return
        }
        let query = "UPDATE `clients` SET `login` = ?, `name` = ?, `email` = ?, `password` = ?, `salt` = ?, `token` = ? WHERE `id` = ?"
        let arguments: [NodeRepresentable] = [client.login, client.name, client.email, client.password, client.salt, client.token, id]
        try db.execute(query, arguments, connection)
    }
    
    // MARK: Fetch
    
    func fetchClient(by email: String, from db: Database, on connection: Connection) throws -> Client? {
        let query = "SELECT * FROM `clients` WHERE `email` = ?;"
        let arguments: [NodeRepresentable] = [email]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Client(with: row)
    }
    
    
    // MARK: - Vendor
    
    // MARK: CRUD
    
    func addVendor(_ vendor: Vendor, to db: Database, on connection: Connection) throws -> Int {
        let query = "INSERT INTO `vendors` (login, name, email, password, salt, token) VALUES (?, ?, ?, ?, ?, ?)"
        let arguments = [vendor.login, vendor.name, vendor.email, vendor.password, vendor.salt, vendor.token]
        // insert
        try db.execute(query, arguments, connection)
        // fetch id
        return try self.fetchClient(by: vendor.email, from: db, on: connection)!.id!
    }
    
    func updateVendor(_ vendor: Vendor, in db: Database, on connection: Connection) throws {
        guard let id = vendor.id else {
            return
        }
        let query = "UPDATE `vendors` SET `login` = ?, `name` = ?, `email` = ?, `password` = ?, `salt` = ?, `token` = ? WHERE `id` = ?"
        let arguments: [NodeRepresentable] = [vendor.login, vendor.name, vendor.email, vendor.password, vendor.salt, vendor.token, id]
        try db.execute(query, arguments, connection)
    }
    
    // MARK: Fetch
    
    func fetchVendor(by email: String, from db: Database, on connection: Connection) throws -> Vendor? {
        let query = "SELECT * FROM `vendors` WHERE `email` = ?;"
        let arguments: [NodeRepresentable] = [email]
        let rows = try db.execute(query, arguments, connection)
        guard let row = rows.first else {
            return nil
        }
        return Vendor(with: row)
    }
    
    
}
