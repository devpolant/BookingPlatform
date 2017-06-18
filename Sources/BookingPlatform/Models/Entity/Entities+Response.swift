//
//  Entities+JSON.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 18.06.17.
//
//

import Foundation

protocol ResponseRepresentable {
    var responseDictionary: [String: Any] { get }
}

extension Client: ResponseRepresentable {
    
    var responseDictionary: [String: Any] {
        var result = [String: Any]()
        
        result["id"] = self.id
        result["login"] = self.login
        result["name"] = self.name
        result["email"] = self.email
        result["token"] = self.token
        
        return result
    }
}

extension Vendor: ResponseRepresentable {
    
    var responseDictionary: [String: Any] {
        var result = [String: Any]()
        
        result["id"] = self.id
        result["login"] = self.login
        result["name"] = self.name
        result["email"] = self.email
        result["token"] = self.token
        
        return result
    }
}

extension Location: ResponseRepresentable {
    
    var responseDictionary: [String: Any] {
        var result = [String: Any]()
        
        result["id"] = self.id
        result["vendor_id"] = self.vendorId
        result["name"] = self.name
        result["latitude"] = self.coordinate.latitude
        result["longitude"] = self.coordinate.longitude
        
        return result
    }
}

extension Place: ResponseRepresentable {

    var responseDictionary: [String: Any] {
        var result = [String: Any]()
        
        result["id"] = self.id
        result["location_id"] = self.locationId
        result["place_number"] = self.number
        
        return result
    }
}

extension Order: ResponseRepresentable {
    
    var responseDictionary: [String: Any] {
        var result = [String: Any]()
        
        result["id"] = self.id
        result["location_id"] = self.locationId
        result["client_id"] = self.clientId
        result["date_from"] = self.dateFrom.timeIntervalSince1970
        result["date_to"] = self.dateTo.timeIntervalSince1970
        
        return result
    }
}

extension OrderItem: ResponseRepresentable {
    
    var responseDictionary: [String: Any] {
        var result = [String: Any]()
        
        result["id"] = self.id
        result["order_id"] = self.orderId
        result["place_id"] = self.placeId
        
        return result
    }
}
