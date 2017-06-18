//
//  Database+Transaction.swift
//  BookingPlatform
//
//  Created by Anton Poltoratskyi on 18.06.17.
//
//

import MySQL

extension Database {
    
    func beginTransaction(connection: Connection) throws {
        try self.execute("SET autocommit=0;", [], connection)
    }
    
    func commitTransaction(connection: Connection) throws {
        try self.execute("COMMIT;", [], connection)
    }
}
