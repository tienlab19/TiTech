//
//  NewResponse.swift
//  TiTech
//
//  Created by Apple on 10/7/24.
//

import Foundation

class CategoryResponse: Codable {
    let data: [NewCategory]?
    let meta: Meta?
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
        case meta = "meta"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([NewCategory].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }
}

class NewCategory: Codable {
    let id: Int?
    let attributes: Attributes?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case attributes = "attributes"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
}

class Attributes: Codable {
    let title: String?
    let createdAt: String?
    let updatedAt: String?
    let publishedAt: String?
    let Publicationstate: String?
    let order: Int?

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
        case Publicationstate = "Publicationstate"
        case order = "order"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        Publicationstate = try values.decodeIfPresent(String.self, forKey: .Publicationstate)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
    }

}

class Meta: Codable {

    let pagination: Pagination?

    private enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

class Pagination: Codable {

    let page: Int?
    let pageSize: Int?
    let pageCount: Int?
    let total: Int?

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case pageSize = "pageSize"
        case pageCount = "pageCount"
        case total = "total"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}
