//
//  NewListData.swift
//  TiTech
//
//  Created by Apple on 10/7/24.
//

import Foundation

class NewListData: Codable {
    let data: [NewsItem]?
    let meta: Meta?

    private enum CodingKeys: String, CodingKey {
        case data = "data"
        case meta = "meta"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([NewsItem].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }
}

class NewsItem: Codable {
    let id: Int?
    let attributes: NewsAtrribute?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case attributes = "attributes"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(NewsAtrribute.self, forKey: .attributes)
    }
}

class NewsAtrribute: Codable {
    let createdAt: String?
    let title: String?
    let updatedAt: String?
    let publishedAt: String?
    let description: String?
    let urlDanLinkLienKet: String?
    let publicationState: String?
    let image: Image?
    let danhMucTinTuc: DanhMucTinTuc?
    let nguonTinTuc: NguonTinTuc?
    
    private enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case title = "title"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
        case description = "description"
        case urlDanLinkLienKet = "url_dan_link_lien_ket"
        case publicationState = "publicationState"
        case image = "image"
        case danhMucTinTuc = "danh_muc_tin_tuc"
        case nguonTinTuc = "nguon_tin_tuc"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        urlDanLinkLienKet = try values.decodeIfPresent(String.self, forKey: .urlDanLinkLienKet)
        publicationState = try values.decodeIfPresent(String.self, forKey: .publicationState)
        image = try values.decodeIfPresent(Image.self, forKey: .image)
        danhMucTinTuc = try values.decodeIfPresent(DanhMucTinTuc.self, forKey: .danhMucTinTuc)
        nguonTinTuc = try values.decodeIfPresent(NguonTinTuc.self, forKey: .nguonTinTuc)
    }
}

class NguonTinTuc: Codable {
    let data: NguonTinTucContent?
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(NguonTinTucContent.self, forKey: .data)
    }
}

class NguonTinTucContent: Codable {
    let id: Int?
    let attributes: NguonTinTucAttributes?
    
    enum CodingKeys: CodingKey {
        case id
        case attributes
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.attributes = try container.decodeIfPresent(NguonTinTucAttributes.self, forKey: .attributes)
    }
}

class NguonTinTucAttributes: Codable {
    let title: String?
    
    enum CodingKeys: CodingKey {
        case title
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }
}

class DanhMucTinTuc: Codable {
    let data: DanhMucTinTucContent?
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(DanhMucTinTucContent.self, forKey: .data)
    }
}

class DanhMucTinTucContent: Codable {
    let id: Int?
    let attributes: DanhMucTinTucAttributes?
    
    enum CodingKeys: CodingKey {
        case id
        case attributes
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.attributes = try container.decodeIfPresent(DanhMucTinTucAttributes.self, forKey: .attributes)
    }
}

class DanhMucTinTucAttributes: Codable {
    let title: String?
    
    enum CodingKeys: CodingKey {
        case title
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }
}

class Image: Codable {

    let data: ImageData?

    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ImageData.self, forKey: .data)
    }
}

class ImageData: Codable {

    let id: Int?
    let attributes: ImageAtributes?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case attributes = "attributes"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(ImageAtributes.self, forKey: .attributes)
    }

}

class ImageAtributes: Codable {
    let name: String?
    let width: Int?
    let height: Int?
    let formats: Formats?
    let hash: String?
    let ext: String?
    let mime: String?
    let size: Double?
    let url: String?
    let provider: String?
    let createdAt: String?
    let updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case width = "width"
        case height = "height"
        case formats = "formats"
        case hash = "hash"
        case ext = "ext"
        case mime = "mime"
        case size = "size"
        case url = "url"
        case provider = "provider"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        formats = try values.decodeIfPresent(Formats.self, forKey: .formats)
        hash = try values.decodeIfPresent(String.self, forKey: .hash)
        ext = try values.decodeIfPresent(String.self, forKey: .ext)
        mime = try values.decodeIfPresent(String.self, forKey: .mime)
        size = try values.decodeIfPresent(Double.self, forKey: .size)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        provider = try values.decodeIfPresent(String.self, forKey: .provider)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}

class Formats: Codable {

    let thumbnail: Thumbnail?
    let medium: Medium?
    let small: Small?

    private enum CodingKeys: String, CodingKey {
        case thumbnail = "thumbnail"
        case medium = "medium"
        case small = "small"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        medium = try values.decodeIfPresent(Medium.self, forKey: .medium)
        small = try values.decodeIfPresent(Small.self, forKey: .small)
    }

}

class Thumbnail: Codable {

    let name: String?
    let hash: String?
    let ext: String?
    let mime: String?
    let width: Int?
    let height: Int?
    let size: Double?
    let url: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case hash = "hash"
        case ext = "ext"
        case mime = "mime"
        case width = "width"
        case height = "height"
        case size = "size"
        case url = "url"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        hash = try values.decodeIfPresent(String.self, forKey: .hash)
        ext = try values.decodeIfPresent(String.self, forKey: .ext)
        mime = try values.decodeIfPresent(String.self, forKey: .mime)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        size = try values.decodeIfPresent(Double.self, forKey: .size)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}

class Medium: Codable {

    let name: String?
    let hash: String?
    let ext: String?
    let mime: String?
    let width: Int?
    let height: Int?
    let size: Double?
    let url: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case hash = "hash"
        case ext = "ext"
        case mime = "mime"
        case width = "width"
        case height = "height"
        case size = "size"
        case url = "url"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        hash = try values.decodeIfPresent(String.self, forKey: .hash)
        ext = try values.decodeIfPresent(String.self, forKey: .ext)
        mime = try values.decodeIfPresent(String.self, forKey: .mime)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        size = try values.decodeIfPresent(Double.self, forKey: .size)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}

class Small: Codable {

    let name: String?
    let hash: String?
    let ext: String?
    let mime: String?
    let width: Int?
    let height: Int?
    let size: Double?
    let url: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case hash = "hash"
        case ext = "ext"
        case mime = "mime"
        case width = "width"
        case height = "height"
        case size = "size"
        case url = "url"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        hash = try values.decodeIfPresent(String.self, forKey: .hash)
        ext = try values.decodeIfPresent(String.self, forKey: .ext)
        mime = try values.decodeIfPresent(String.self, forKey: .mime)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        size = try values.decodeIfPresent(Double.self, forKey: .size)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
