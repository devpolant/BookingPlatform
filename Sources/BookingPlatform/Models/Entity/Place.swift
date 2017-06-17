//
//  File.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

final class Place {
    typealias PlaceNumber = Int
    
    var id: Int?
    var locationId: Int
    var number: PlaceNumber
    
    init(id: Int? = nil, locationId: Int, number: PlaceNumber) {
        self.id = id
        self.locationId = locationId
        self.number = number
    }
}
