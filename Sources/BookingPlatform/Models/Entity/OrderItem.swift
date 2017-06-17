//
//  OrderItem.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Foundation

class OrderItem {
    
    var id: Int?
    var orderId: Int
    var placeId: Int
    
    init(id: Int? = nil, orderId: Int, placeId: Int) {
        self.id = id
        self.orderId = orderId
        self.placeId = placeId
    }
}
