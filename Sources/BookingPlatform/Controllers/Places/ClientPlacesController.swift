//
//  ClientPlacesController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Kitura

class ClientPlacesController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
    }
}
