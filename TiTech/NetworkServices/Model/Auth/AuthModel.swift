//
//  AuthModel.swift
//  tinvay
//
//  Created by Apple on 27/6/24.
//

import Foundation

class AuthModel: Codable {
    var token: String?
    var success: Bool?
    var message: String?
    
    enum CodingKeys: CodingKey {
        case token
        case success
        case message
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.token = try? container.decodeIfPresent(String.self, forKey: .token)
        self.success = try? container.decodeIfPresent(Bool.self, forKey: .success)
        self.message = try? container.decodeIfPresent(String.self, forKey: .message)
    }
}
