//
//  CarrerBlogAPIs.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//

import Foundation
import Moya

enum VietCeteraAPIs {
    case CARRER_BLOG(page: Int)
    case BANNER_HEADER
    case TAG
    case POPULAR_ARTICAL
}

extension VietCeteraAPIs: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL.vietCetera.path)!
    }
    
    var path: String {
        switch self {
        case .CARRER_BLOG:
            return BaseURL.vietCetera.endpoint
            
        case .BANNER_HEADER:
            return BaseURL.vietCeteraBannerHeader.endpoint
        
        case .TAG:
            return BaseURL.tags.endpoint
            
        case .POPULAR_ARTICAL:
            return BaseURL.popularArtical.endpoint
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .CARRER_BLOG, .BANNER_HEADER, .TAG, .POPULAR_ARTICAL:
            return .get
        }
    }
    
    var task: Moya.Task {
        let encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case .CARRER_BLOG(let page):
            let parameters: [String: Any] = [
                "limit": 8,
                "isIgnoreFeatureArticle": "false",
                "page": page,
                "language": "VN",
                "groupTopic": "su-nghiep",
                "avatarImageSizes": ["ONE_ONE_160x160"],
                "aricleImageSizes": ["SIX_NINE_768x432",
                                     "SIX_NINE_1152x648",
                                     "SIX_NINE_375x211",
                                     "THREE_TWO_268x178",
                                     "THREE_TWO_536x356",
                                     "THREE_TWO_468x312",
                                     "THREE_TWO_936x624"],
                "thumbnailImageSizes": ["SIX_NINE_768x432",
                                        "SIX_NINE_1152x648",
                                        "SIX_NINE_375x211",
                                        "THREE_TWO_536x356",
                                        "THREE_TWO_468x312",
                                        "THREE_TWO_936x624"]
            ]
            return .requestParameters(parameters: parameters, encoding: encoding)
            
        case .BANNER_HEADER:
            let paramaters: [String: Any] = [
                "language": "VN",
                "type": "BILLBOARD"
            ]
            return .requestParameters(parameters: paramaters, encoding: encoding)
            
        case .TAG:
            return .requestPlain
            
        case .POPULAR_ARTICAL:
            let parameters: [String: Any] = [
                "language":"VN",
                "limit":5,
                "sortBy":"recommendViewRanking",
                "isNoBookmark":"true",
                "isNoAuthor":"true",
                "thumbnailImageSizes": ["SIX_NINE_375x211",
                                        "SIX_NINE_1152x648",
                                        "SIX_NINE_768x432"],
                "articleImageSizes": ["SIX_NINE_375x211",
                                      "SIX_NINE_1152x648",
                                      "SIX_NINE_768x432"]
            ]
            
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .CARRER_BLOG, .BANNER_HEADER, .TAG, .POPULAR_ARTICAL:
            return [
                HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
                HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
                HTTPHeaderField.vietceteraApiKey.rawValue: ContentType.vietceteraApiKey.rawValue,
            ]
        }
    }
}
