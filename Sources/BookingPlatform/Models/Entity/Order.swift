//
//  Order.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Foundation

final class Order {
    
    var id: Int?
    var locationId: Int
    var clientId: Int
    var dateFrom: Date
    var dateTo: Date
    
    init(id: Int? = nil, locationId: Int, clientId: Int, dateTimeFrom: TimeInterval, dateTimeTo: TimeInterval) {
        self.id = id
        self.locationId = locationId
        self.clientId = clientId
        self.dateFrom = Date(timeIntervalSince1970: dateTimeFrom)
        self.dateTo = Date(timeIntervalSince1970: dateTimeTo)
    }
}
