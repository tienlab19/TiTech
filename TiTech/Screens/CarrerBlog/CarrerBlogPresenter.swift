//
//  
//  CarrerBlogPresenter.swift
//  TiTech
//
//  Created by Apple on 18/7/24.
//
//

import UIKit

class CarrerBlogPresenter {

    weak var view: CarrerBlogViewProtocol?
    private var interactor: CarrerBlogInteractorInputProtocol
    private var router: CarrerBlogRouterProtocol
    
    var page: Int = 1
    var blogDoc: [Docs]? = []

    init(interactor: CarrerBlogInteractorInputProtocol,
         router: CarrerBlogRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - CarrerBlogPresenterProtocol
extension CarrerBlogPresenter: CarrerBlogPresenterProtocol {
    func onViewDidLoad() {
        self.view?.showHud()
        self.interactor.requestGetArticals(page: self.page)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: CarrerBlog.self, for: indexPath)
        if let item = self.blogDoc?[indexPath.row] {
            cell.thumnailImage.setImageVietcetera(imageUrl: item.images?.size?.sIX_NINE_1152x648?.url ?? "")
            cell.mainTitle.text = item.title ?? ""
            cell.subTitle.text = item.excerpt ?? ""
            cell.author.text = item.writer?.penname ?? ""
            cell.topic.text = "| " + (item.topic?.first?.name ?? "")
            return cell
        } else {
            return cell
        }
    }
}

// MARK: - CarrerBlogInteractorOutput 
extension CarrerBlogPresenter: CarrerBlogInteractorOutputProtocol {
    func didGetArticals(with result: Result<CarrerBlogModel?, APIError>) {
        self.view?.hideHud()
        switch result {
        case .success(let model):
            self.blogDoc = model?.data?.docs
            self.view?.reloadContents()
        case .failure(let error):
            print(error)
        }
    }
}
