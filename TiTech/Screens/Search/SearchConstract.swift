//
//  
//  SearchConstract.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//
//

import UIKit

// MARK: - View
protocol SearchViewProtocol: AnyObject {
    func showHud()
    func hideHud()
}

// MARK: - Presenter
protocol SearchPresenterProtocol {
    var listTags: [TagDoc]? { get set }
    var listPopularArtical: [Docs]? { get set }
    
    func onViewDidLoad()
}

// MARK: - Interactor Input
protocol SearchInteractorInputProtocol {
    func requestGetTagsAll()
    func requestGetPopularArtical()
}

// MARK: - Interactor Output
protocol SearchInteractorOutputProtocol: AnyObject {
    func didGetTags(with result: Result<TagsModel?, APIError>)
    func didGetPopularArtical(with result: Result<CarrerBlogModel?, APIError>)
}

// MARK: - Router
protocol SearchRouterProtocol {

}
