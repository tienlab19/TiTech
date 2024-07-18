//
//  CarrerBlogModel.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//

import Foundation

struct CarrerBlogModel: Codable {
    let data : DocumentData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(DocumentData.self, forKey: .data)
    }
}


struct DocumentData: Codable {
    let docs : [Docs]?

    enum CodingKeys: String, CodingKey {
        case docs = "docs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([Docs].self, forKey: .docs)
    }
}
