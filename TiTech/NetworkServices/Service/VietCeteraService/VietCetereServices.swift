//
//  VietCetereServices.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//

import Foundation

protocol VietCetereServicesProtocols {
    func getListArticle(page: Int, completion: @escaping ((Result<CarrerBlogModel?, APIError>) -> Void))
    func getListBannerHeader(completion: @escaping ((Result<BannerHeaderModel?, APIError>) -> Void))
    func getTags(completion: @escaping ((Result<TagsModel?, APIError>) -> Void))
    func getPopularArtical(completion: @escaping ((Result<CarrerBlogModel?, APIError>) -> Void))
}

//MARK: - VietCetereServicesProtocols
class VietCetereServices: VietCetereServicesProtocols {

    let service = BaseService.shared
    
    func getListArticle(page: Int, completion: @escaping ((Result<CarrerBlogModel?, APIError>) -> Void)) {
        NetworkingManager.vietceteraApiProvider.request(.CARRER_BLOG(page: page)) { result in
            completion(self.service.handle(result, type: CarrerBlogModel.self))
        }
    }
    
    func getListBannerHeader(completion: @escaping ((Result<BannerHeaderModel?, APIError>) -> Void)) {
        NetworkingManager.vietceteraApiProvider.request(.BANNER_HEADER) { result in
            completion(self.service.handle(result, type: BannerHeaderModel.self))
        }
    }
    
    func getTags(completion: @escaping ((Result<TagsModel?, APIError>) -> Void)) {
        NetworkingManager.vietceteraApiProvider.request(.TAG) { result in
            completion(self.service.handle(result, type: TagsModel.self))
        }
    }
    
    func getPopularArtical(completion: @escaping ((Result<CarrerBlogModel?, APIError>) -> Void)) {
        NetworkingManager.vietceteraApiProvider.request(.POPULAR_ARTICAL) { result in
            completion(self.service.handle(result, type: CarrerBlogModel.self))
        }
    }
}
