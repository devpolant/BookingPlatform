//
//  RouteRepresentable.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

protocol RouteRepresentable {
    init(baseRouter: Router)
    func setupRoutes()
}
