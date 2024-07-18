//
//  BaseURL.swift
//  TiTech
//
//  Created by Apple on 11/7/24.
//

import Foundation

enum BaseURL: String {
    case chatAI
    case category
    case newsList
    case vietCetera
    
    var path: String {
        switch self {
        case .category, .newsList:
            return "https://cms.1sk.vn/api"
            
        case .chatAI:
            return "https://api.openai.com/v1"
            
        case .vietCetera:
            return "https://api.vietcetera.com/client/api/v2"
        }
    }
    
    var endpoint: String {
        switch self {
        case .category:
            return "/danh-muc-tin-tucs"
            
        case .newsList:
            return "/tin-tuc-apps"
            
        case .chatAI:
            return "/chat/completions"
            
        case .vietCetera:
            return "/latest-article"
        }
    }
}
