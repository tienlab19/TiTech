//
//  
//  SearchPresenter.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//
//

import UIKit

class SearchPresenter {

    weak var view: SearchViewProtocol?
    private var interactor: SearchInteractorInputProtocol
    private var router: SearchRouterProtocol
    
    var listTags: [TagDoc]? = []
    var listPopularArtical: [Docs]? = []

    init(interactor: SearchInteractorInputProtocol,
         router: SearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func onViewDidLoad() {
        self.view?.showHud()
        self.interactor.requestGetTagsAll()
    }
}

// MARK: - SearchInteractorOutput 
extension SearchPresenter: SearchInteractorOutputProtocol {
    func didGetTags(with result: Result<TagsModel?, APIError>) {
        switch result {
        case .success(let model):
            guard let responseData = model?.data?.docs else { return }
            self.listTags = responseData
            self.interactor.requestGetPopularArtical()
            
        case .failure(let failure):
            print(failure.message)
            self.view?.hideHud()
        }
    }
    
    func didGetPopularArtical(with result: Result<CarrerBlogModel?, APIError>) {
        switch result {
        case .success(let model):
            guard let responseData = model?.data?.docs else { return }
            self.listPopularArtical = responseData
            
        case .failure(let failure):
            print(failure.message)
        }
        
        self.view?.hideHud()
    }
}
