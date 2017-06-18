//
//  CryptoManager.swift
//  NTPServer
//
//  Created by Anton Poltoratskyi on 30.03.17.
//
//

import Cryptor

class Cipher {
    
    static let shared = Cipher()
    private init() {}
    
    func password(from string: String, salt: String) -> String {
        
        let key = PBKDF.deriveKey(fromPassword: string,
                                  salt: salt,
                                  prf: .sha512,
                                  rounds: 250_000,
                                  derivedKeyLength: 64)
        
        return CryptoUtils.hexString(from: key)
    }
    
    func salt(fields: [String]) -> String {
        let saltString: String
        if let salt = try? Random.generate(byteCount: 64) {
            saltString = CryptoUtils.hexString(from: salt)
        } else {
            saltString = fields.joined().digest(using: .sha512)
        }
        return saltString
    }
}
