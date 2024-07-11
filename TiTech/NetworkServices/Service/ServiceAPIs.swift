//
//  API.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//

import Foundation
import Moya

enum NetworkingAPI {
    case sendMessage(message: String)
    case newsCategory
    case newsList(categoryId: Int)
}

extension NetworkingAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .sendMessage(_):
            return URL(string: BaseURL.chatAI.path)!
        case .newsCategory, .newsList:
            return URL(string: BaseURL.newsList.path)!
        }
    }
    
    var path: String {
        switch self {
        case .sendMessage:
            return BaseURL.chatAI.endpoint
        case .newsCategory:
            return BaseURL.category.endpoint
        case .newsList:
            return BaseURL.newsList.endpoint
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendMessage:
            return .post
        case .newsCategory, .newsList:
            return .get
        }
    }
    
    var task: Task {
        let encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case .sendMessage(let message):
            let parameters: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [
                    ["role": "system", "content": "You are a helpful assistant."],
                    ["role": "user", "content": message]
                ]
            ]
            return .requestParameters(parameters: parameters, encoding: encoding)
        case .newsCategory:
            return .requestPlain
        case .newsList(let categoryId):
            let parameters: [String: Any] = [
                "populate": "image,danh_muc_tin_tuc,nguon_tin_tuc",
                "sort": "createdAt:desc",
                "filters[danh_muc_tin_tuc][id]": categoryId,
            ]
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .sendMessage:
            return [
                HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
            ]
        case .newsCategory, .newsList:
            return [
                HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
            ]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
