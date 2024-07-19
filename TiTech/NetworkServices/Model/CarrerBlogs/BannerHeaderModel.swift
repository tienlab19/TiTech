//
//  BannerHeaderModel.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//

import Foundation

struct BannerHeaderModel: Codable {
    let data: BannerData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(BannerData.self, forKey: .data)
    }
}


struct BannerData: Codable {
    let banner: [Banner]?
    
    enum CodingKeys: String, CodingKey {
        case banner = "banner"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.banner = try container.decodeIfPresent([Banner].self, forKey: .banner)
    }
}

struct Banner: Codable {
    
    let from: Double?
    let to: Double?
    let id: String?
    let retina: String?
    let mobileRetina: String?
    let desktop: String?
    let mobile: String?
    let ratio: Int?
    let url: String?
    let newTab: Bool?
    let doFollow: Bool?
    let trackingClass: String?
    let alt: String?
    let addedOn: String?
    let endDate: String?

    enum CodingKeys: String, CodingKey {
        case from
        case to
        case id
        case retina
        case mobileRetina
        case desktop
        case mobile
        case ratio
        case url
        case newTab
        case doFollow
        case trackingClass
        case alt
        case addedOn
        case endDate
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.from = try container.decodeIfPresent(Double.self, forKey: .from)
        self.to = try container.decodeIfPresent(Double.self, forKey: .to)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.retina = try container.decodeIfPresent(String.self, forKey: .retina)
        self.mobileRetina = try container.decodeIfPresent(String.self, forKey: .mobileRetina)
        self.desktop = try container.decodeIfPresent(String.self, forKey: .desktop)
        self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile)
        self.ratio = try container.decodeIfPresent(Int.self, forKey: .ratio)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.newTab = try container.decodeIfPresent(Bool.self, forKey: .newTab)
        self.doFollow = try container.decodeIfPresent(Bool.self, forKey: .doFollow)
        self.trackingClass = try container.decodeIfPresent(String.self, forKey: .trackingClass)
        self.alt = try container.decodeIfPresent(String.self, forKey: .alt)
        self.addedOn = try container.decodeIfPresent(String.self, forKey: .addedOn)
        self.endDate = try container.decodeIfPresent(String.self, forKey: .endDate)
    }

}
