//
//  VietCetereServices.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//

import Foundation

protocol VietCetereServicesProtocols {
    func getListArticle(page: Int, completion: @escaping ((Result<CarrerBlogModel?, APIError>) -> Void))
}

//MARK: - VietCetereServicesProtocols
class VietCetereServices: VietCetereServicesProtocols {
    let service = BaseService.shared
    
    func getListArticle(page: Int, completion: @escaping ((Result<CarrerBlogModel?, APIError>) -> Void)) {
        NetworkingManager.vietceteraApiProvider.request(.CARRER_BLOG(page: page)) { result in
            completion(self.service.handle(result, type: CarrerBlogModel.self))
        }
    }
}
