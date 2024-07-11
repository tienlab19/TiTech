//
//  ChatService.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//

import Foundation
import Moya
import Alamofire

protocol ChatServiceProtocols {
    func sendMessage(message: String, completion: @escaping (Result<ChatModel?, APIError>) -> Void)
}

//MARK: - ChatServiceProtocols -
class ChatService: ChatServiceProtocols {
    private let provider: MoyaProvider<NetworkingAPI>
    private let service = BaseService.shared
    
    init() {
        self.provider = NetworkingManager.apiProvider
    }
    
    func sendMessage(message: String, completion: @escaping (Result<ChatModel?, APIError>) -> Void) {
        self.provider.request(.sendMessage(message: message)) { result in
            completion(self.service.handle(result, type: ChatModel.self))
        }
    }
}
