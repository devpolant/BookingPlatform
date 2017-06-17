//
//  Order.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Foundation

class Order {
    
    var id: Int?
    var vendorId: Int
    var clientId: Int
    var date: Date
    
    init(id: Int? = nil, vendorId: Int, clientId: Int, dateTime: TimeInterval) {
        self.id = id
        self.vendorId = vendorId
        self.clientId = clientId
        self.date = Date(timeIntervalSince1970: dateTime)
    }
}
