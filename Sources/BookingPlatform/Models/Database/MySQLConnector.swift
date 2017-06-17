//
//  DBConnector.swift
//  NTPServer
//
//  Created by Anton Poltoratskyi on 28.03.17.
//
//

import MySQL

class MySQLConnector {
    
    static func connectToDatabase() throws -> (Database, Connection) {
        let mysql = try Database(
            host: "localhost",
            user: "root",
            password: "root",
            database: "booking_platform"
        )
        let connection = try mysql.makeConnection()
        return (mysql, connection)
    }
}
