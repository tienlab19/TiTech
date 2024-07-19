//
//  TagsModel.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//

import Foundation

struct TagsModel: Codable {
    let errorCode: Int?
    let message: String?
    let data: TagData?

    private enum CodingKeys: String, CodingKey {
        case errorCode = "errorCode"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(TagData.self, forKey: .data)
    }
}

struct TagData: Codable {
    let docs: [TagDoc]?
    let isNextPage: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case docs = "docs"
        case isNextPage = "isNextPage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([TagDoc].self, forKey: .docs)
        isNextPage = try values.decodeIfPresent(Bool.self, forKey: .isNextPage)
    }
}

struct TagDoc: Codable {
    
    let name: String?
    let slug: String?
    let id: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case slug = "slug"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }
}
