//
//  
//  CarrerBlogInteractorInput.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//
//

import UIKit

class CarrerBlogInteractorInput {
    weak var output: CarrerBlogInteractorOutputProtocol?
    
    private let service: VietCetereServicesProtocols?
    
    init(service: VietCetereServicesProtocols?) {
        self.service = service
    }
}

// MARK: - CarrerBlogInteractorInputProtocol
extension CarrerBlogInteractorInput: CarrerBlogInteractorInputProtocol {
    func requestGetArticals(page: Int) {
        self.service?.getListArticle(page: page, completion: { completion in
            self.output?.didGetArticals(with: completion)
        })
    }
}
