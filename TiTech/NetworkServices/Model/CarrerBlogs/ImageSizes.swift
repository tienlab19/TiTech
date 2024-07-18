//
//  ImageSizes.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//

import Foundation

struct ImageSizes: Codable {
    let sIX_NINE_375x211: SIX_NINE_375x211?
    let sIX_NINE_768x432: SIX_NINE_768x432?
    let sIX_NINE_1152x648: SIX_NINE_1152x648?
    let tHREE_TWO_268x178: THREE_TWO_268x178?
    let tHREE_TWO_468x312: THREE_TWO_468x312?
    let tHREE_TWO_536x356: THREE_TWO_536x356?
    let tHREE_TWO_936x624: THREE_TWO_936x624?
    
    enum CodingKeys: String, CodingKey {
        case sIX_NINE_375x211  = "SIX_NINE_375x211"
        case sIX_NINE_768x432  = "SIX_NINE_768x432"
        case sIX_NINE_1152x648 = "SIX_NINE_1152x648"
        case tHREE_TWO_268x178 = "THREE_TWO_268x178"
        case tHREE_TWO_468x312 = "THREE_TWO_468x312"
        case tHREE_TWO_536x356 = "THREE_TWO_536x356"
        case tHREE_TWO_936x624 = "THREE_TWO_936x624"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sIX_NINE_375x211 = try container.decodeIfPresent(SIX_NINE_375x211.self, forKey: .sIX_NINE_375x211)
        self.sIX_NINE_768x432 = try container.decodeIfPresent(SIX_NINE_768x432.self, forKey: .sIX_NINE_768x432)
        self.sIX_NINE_1152x648 = try container.decodeIfPresent(SIX_NINE_1152x648.self, forKey: .sIX_NINE_1152x648)
        self.tHREE_TWO_268x178 = try container.decodeIfPresent(THREE_TWO_268x178.self, forKey: .tHREE_TWO_268x178)
        self.tHREE_TWO_468x312 = try container.decodeIfPresent(THREE_TWO_468x312.self, forKey: .tHREE_TWO_468x312)
        self.tHREE_TWO_536x356 = try container.decodeIfPresent(THREE_TWO_536x356.self, forKey: .tHREE_TWO_536x356)
        self.tHREE_TWO_936x624 = try container.decodeIfPresent(THREE_TWO_936x624.self, forKey: .tHREE_TWO_936x624)
    }
}
