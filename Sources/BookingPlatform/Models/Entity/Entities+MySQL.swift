//
//  Entities+MySQL.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Foundation
import MySQL

// MARK: - Protocols

protocol MySQLInitializable {
    init(with node: [String: Node])
}

// MARK: - Extensions

extension Client: MySQLInitializable {
    
    convenience init(with node: [String: Node]) {
        let id = node["id"]?.int
        let login = node["login"]!.string!
        let name = node["name"]!.string!
        let email = node["email"]!.string!
        let password = node["password"]!.string!
        let salt = node["salt"]!.string!
        let token = node["token"]!.string!
        self.init(id: id, login: login, name: name, email: email, password: password, salt: salt, token: token)
    }
}

extension Vendor: MySQLInitializable {
    
    convenience init(with node: [String: Node]) {
        let id = node["id"]?.int
        let login = node["login"]!.string!
        let name = node["name"]!.string!
        let email = node["email"]!.string!
        let password = node["password"]!.string!
        let salt = node["salt"]!.string!
        let token = node["token"]!.string!
        self.init(id: id, login: login, name: name, email: email, password: password, salt: salt, token: token)
    }
}

extension Location: MySQLInitializable {
    
    convenience init(with node: [String: Node]) {
        let id = node["id"]?.int
        let name = node["name"]!.string!
        let vendorId = node["vendor_id"]!.int!
        let latitude = node["latitude"]!.double!
        let longitude = node["longitude"]!.double!
        let coordinate = Coordinate(latitude: latitude,
                                    longitude: longitude)
        self.init(id: id, name: name, coordinate: coordinate, vendorId: vendorId)
    }
}

extension Place: MySQLInitializable {
    
    convenience init(with node: [String: Node]) {
        let id = node["id"]?.int
        let locationId = node["location_id"]!.int!
        let placeNumber = node["place_number"]!.int!
        self.init(id: id, locationId: locationId, number: placeNumber)
    }
}

extension Order: MySQLInitializable {
    
    convenience init(with node: [String: Node]) {
        let id = node["id"]?.int
        let vendorId = node["vendor_id"]!.int!
        let clientId = node["client_id"]!.int!
        let dateFrom = node["date_from"]!.int!
        let dateTo = node["date_to"]!.int!
        self.init(id: id, vendorId: vendorId, clientId: clientId, dateTimeFrom: TimeInterval(dateFrom), dateTimeTo: TimeInterval(dateTo))
    }
}

extension OrderItem: MySQLInitializable {
    
    convenience init(with node: [String: Node]) {
        let id = node["id"]?.int
        let orderId = node["order_id"]!.int!
        let placeId = node["place_id"]!.int!
        self.init(id: id, orderId: orderId, placeId: placeId)
    }
}
