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
    var dateFrom: Date
    var dateTo: Date
    
    init(id: Int? = nil, vendorId: Int, clientId: Int, dateTimeFrom: TimeInterval, dateTimeTo: TimeInterval) {
        self.id = id
        self.vendorId = vendorId
        self.clientId = clientId
        self.dateFrom = Date(timeIntervalSince1970: dateTimeFrom)
        self.dateTo = Date(timeIntervalSince1970: dateTimeTo)
    }
}
