//
//  
//  SearchRouter.swift
//  TiTech
//
//  Created by Tien Tran on 19/7/24.
//
//

import UIKit

class SearchRouter {
    weak var viewController: SearchViewController?
    static func setupModule() -> SearchViewController {
        let viewController = SearchViewController()
        let service = VietCetereServices()
        let router = SearchRouter()
        let interactorInput = SearchInteractorInput(service: service)
        let presenter = SearchPresenter(interactor: interactorInput, router: router)
        viewController.presenter = presenter
        presenter.view = viewController
        interactorInput.output = presenter
        router.viewController = viewController
        return viewController
    }
}

// MARK: - SearchRouterProtocol
extension SearchRouter: SearchRouterProtocol {
    
}
