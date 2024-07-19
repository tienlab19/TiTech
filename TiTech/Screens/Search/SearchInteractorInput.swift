//
//  
//  SearchInteractorInput.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//
//

import UIKit

class SearchInteractorInput {
    weak var output: SearchInteractorOutputProtocol?
    
    private let service: VietCetereServicesProtocols
    
    init(service: VietCetereServicesProtocols) {
        self.service = service
    }
}

// MARK: - SearchInteractorInputProtocol
extension SearchInteractorInput: SearchInteractorInputProtocol {
    func requestGetTagsAll() {
        self.service.getTags { completion in
            self.output?.didGetTags(with: completion)
        }
    }
    
    func requestGetPopularArtical() {
        self.service.getPopularArtical { completion in
            self.output?.didGetPopularArtical(with: completion)
        }
    }
}
