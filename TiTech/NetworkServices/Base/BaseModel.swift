//
//  BaseModel.swift
//  tinvay
//
//  Created by Apple on 27/6/24.
//

import Foundation

class BaseModel<T: Codable>: Codable {
    var success: Bool?
    var message: String?
    var description: String?
    var code: Int?
    var data: T?
    var errorCode: Int?
    
    enum CodingKeys: CodingKey {
        case success
        case message
        case description
        case code
        case data
        case errorCode
    }
    
    required init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<BaseModel<T>.CodingKeys> = try decoder.container(keyedBy: BaseModel<T>.CodingKeys.self)
        
        self.success = try? container.decodeIfPresent(Bool.self, forKey: BaseModel<T>.CodingKeys.success)
        self.message = try? container.decodeIfPresent(String.self, forKey: BaseModel<T>.CodingKeys.message)
        self.description = try? container.decodeIfPresent(String.self, forKey: BaseModel<T>.CodingKeys.description)
        self.code = try? container.decodeIfPresent(Int.self, forKey: BaseModel<T>.CodingKeys.code)
        self.data = try? container.decodeIfPresent(T.self, forKey: BaseModel<T>.CodingKeys.data)
        self.errorCode = try? container.decodeIfPresent(Int.self, forKey: BaseModel<T>.CodingKeys.errorCode)
    }
}
