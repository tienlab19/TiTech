//
//  ChatModel.swift
//  TiTech
//
//  Created by Apple on 10/7/24.
//

import Foundation

class ChatModel: Codable {
    var content: String?
    
    enum CodingKeys: CodingKey {
        case content
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.content, forKey: .content)
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try container.decode(String.self, forKey: .content)
    }
}
