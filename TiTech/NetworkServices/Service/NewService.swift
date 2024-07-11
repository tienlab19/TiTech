//
//  NewService.swift
//  TiTech
//
//  Created by Apple on 10/7/24.
//

import Foundation
import Moya
import Alamofire

protocol NewServiceProtocols {
    func getNewCategory(completion: @escaping (Result<CategoryResponse?, APIError>) -> Void)
    func getListNews(categoryIds: Int, completion: @escaping (Result<NewListData?, APIError>) -> Void)
}

//MARK: - ChatServiceProtocols -
class NewService: NewServiceProtocols {
    private let service = BaseService.shared
    
    func getNewCategory(completion: @escaping (Result<CategoryResponse?, APIError>) -> Void) {
        NetworkingManager.apiProvider.request(.newsCategory) { result in
            completion(self.service.handle(result, type: CategoryResponse.self))
        }
    }
    
    func getListNews(categoryIds: Int, completion: @escaping (Result<NewListData?, APIError>) -> Void) {
        NetworkingManager.apiProvider.request(.newsList(categoryId: categoryIds)) { result in
            completion(self.service.handle(result, type: NewListData.self))
        }
    }
}
