//
//  
//  CarrerBlogRouter.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//
//

import UIKit

class CarrerBlogRouter {
    weak var viewController: CarrerBlogViewController?
    static func setupModule() -> CarrerBlogViewController {
        let viewController = CarrerBlogViewController()
        let service = VietCetereServices()
        let router = CarrerBlogRouter()
        let interactorInput = CarrerBlogInteractorInput(service: service)
        let presenter = CarrerBlogPresenter(interactor: interactorInput, router: router)
        viewController.presenter = presenter
        presenter.view = viewController
        interactorInput.output = presenter
        router.viewController = viewController
        
        viewController.title = "Sự nghiệp"
        return viewController
    }
}

// MARK: - CarrerBlogRouterProtocol
extension CarrerBlogRouter: CarrerBlogRouterProtocol {
    
}
