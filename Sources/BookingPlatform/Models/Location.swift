//
//  File.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

struct Coordinate {
    var latitude: Double
    var longitude: Double
}

class Location {
    
    var id: Int?
    var name: String
    var coordinate: Coordinate
    var vendorId: Int
    
    init(id: Int? = nil, name: String, coordinate: Coordinate, vendorId: Int) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.vendorId = vendorId
    }
}
