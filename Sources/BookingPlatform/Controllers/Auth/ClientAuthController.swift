//
//  ClientAuthController.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 17.06.17.
//
//

import Foundation
import Kitura
import Cryptor

class ClientAuthController: RouteRepresentable {
    
    private let baseRouter: Router
    
    
    // MARK: - Init
    
    required init(baseRouter: Router) {
        self.baseRouter = baseRouter
    }
    
    
    // MARK: - Routes
    
    func setupRoutes() {
        self.baseRouter.post("/signup", handler: self.signUp)
        self.baseRouter.post("/login", handler: self.login)
    }
    
    // MARK: Auth
    
    func signUp(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        let requiredFields = ["login", "name", "email", "password"]
        
        guard let fields = request.getPost(fields: requiredFields) else {
            try response.badRequest(expected: requiredFields).end()
            return
        }
        let login = fields["login"]!
        let name = fields["name"]!
        let email = fields["email"]!
        let password = fields["password"]!
        
        // salt
        let salt = Cipher.shared.salt(fields: fields.map { $0.value })
        
        // password
        let encryptedPassword = Cipher.shared.password(from: password, salt: salt)
        let token = UUID().uuidString
        
        let client = Client(login: login,
                            name: name,
                            email: email,
                            password: encryptedPassword,
                            salt: salt,
                            token: token)
        
        // save
        let (db, connection) = try MySQLConnector.connectToDatabase()
        do {
            _ = try DatabaseManager.shared.addClient(client, to: db, on: connection)
        } catch {
            let errorMessage = "Error while saving client"
            try response.internalServerError(message: errorMessage).end()
            return
        }
        
        let result: [String: Any] = [
            "error": false,
            "access_token": client.token
        ]
        response.send(json: result)
    }
    
    func login(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        defer { next() }
        
        let requiredFields = ["email", "password"]
        
        guard let fields = request.getPost(fields: requiredFields) else {
            try response.badRequest(expected: requiredFields).end()
            return
        }
        let email = fields["email"]!
        let password = fields["password"]!
        
        let (db, connection) = try MySQLConnector.connectToDatabase()
        guard let client = try DatabaseManager.shared.fetchClient(by: email, from: db, on: connection) else {
            let errorMessage = "Client not found"
            try response.badRequest(message: errorMessage).end()
            return
        }
        
        // Use saved salt from database
        let encryptedPassword = Cipher.shared.password(from: password, salt: client.salt)
        
        guard encryptedPassword == client.password else {
            try response.badRequest(message: "Wrong password or login").end()
            return
        }
        let result: [String: Any] = [
            "error": false,
            "access_token": client.token
        ]
        response.send(json: result)
    }
}
