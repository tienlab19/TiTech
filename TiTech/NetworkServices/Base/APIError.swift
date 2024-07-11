//
//  APIError.swift
//  tinvay
//
//  Created by Apple on 26/6/24.
//

import Foundation

struct APIError: Error, Codable, CustomStringConvertible {
    var message: String
    var statusCode: Int
    
    init(message: String, statusCode: Int) {
        self.message = message
        self.statusCode = statusCode
    }
    
    var description: String {
        return "<API-Error> code: \(statusCode), message: \(message)"
    }
}
