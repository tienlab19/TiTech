//
//  
//  CarrerBlogConstract.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//
//

import UIKit

// MARK: - View
protocol CarrerBlogViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    func reloadContents()
}

// MARK: - Presenter
protocol CarrerBlogPresenterProtocol {
    var page: Int { get set }
    var blogDoc: [Docs]? { get set}
    
    func onViewDidLoad()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
}

// MARK: - Interactor Input
protocol CarrerBlogInteractorInputProtocol {
    func requestGetArticals(page: Int)
}

// MARK: - Interactor Output
protocol CarrerBlogInteractorOutputProtocol: AnyObject {
    func didGetArticals(with result: Result<CarrerBlogModel?, APIError>)
}

// MARK: - Router
protocol CarrerBlogRouterProtocol {

}
