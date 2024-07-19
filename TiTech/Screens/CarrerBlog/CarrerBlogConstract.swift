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
    func reloadBanner(isShow: Bool)
}

// MARK: - Presenter
protocol CarrerBlogPresenterProtocol {
    var page: Int { get set }
    var blogDoc: [Docs] { get set}
    var bannerHeader: [Banner] { get set }
    var isLoadingMore: Bool { get set }
    
    func onViewDidLoad()
    func onLoadMore()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

// MARK: - Interactor Input
protocol CarrerBlogInteractorInputProtocol {
    func requestGetArticals(page: Int)
    func requestGetBannerHeader()
}

// MARK: - Interactor Output
protocol CarrerBlogInteractorOutputProtocol: AnyObject {
    func didGetArticals(with result: Result<CarrerBlogModel?, APIError>)
    func didGetBannerHeader(with result: Result<BannerHeaderModel?, APIError>)
}

// MARK: - Router
protocol CarrerBlogRouterProtocol {

}
