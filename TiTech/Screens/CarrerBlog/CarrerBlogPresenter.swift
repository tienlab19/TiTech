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
    var blogDoc: [Docs] = []
    var isLoadingMore = false

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
        let isBranded = self.blogDoc[indexPath.row].label ?? ""
        cell.thumnailImage.setImageVietcetera(imageUrl: self.blogDoc[indexPath.item].images?.size?.sIX_NINE_1152x648?.url ?? "")
        cell.mainTitle.text = self.blogDoc[indexPath.item].title ?? ""
        cell.subTitle.text = self.blogDoc[indexPath.item].excerpt ?? ""
        cell.author.text = self.blogDoc[indexPath.item].writer?.penname ?? ""
        cell.topic.text = "| " + (self.blogDoc[indexPath.item].topic?.first?.name ?? "")
        cell.brandedView.isHidden = isBranded.isEmpty
        return cell
    }
    
    func onLoadMore() {
        self.page += 1
        self.isLoadingMore = true
        self.view?.showHud()
        self.interactor.requestGetArticals(page: self.page)
    }
}

// MARK: - CarrerBlogInteractorOutput 
extension CarrerBlogPresenter: CarrerBlogInteractorOutputProtocol {
    func didGetArticals(with result: Result<CarrerBlogModel?, APIError>) {
        self.view?.hideHud()
        switch result {
        case .success(let model):
            guard let newData = model?.data?.docs else { return }
            for data in newData {
                if !self.blogDoc.contains(where: { data.title == $0.title}) {
                    self.blogDoc.append(data)
                }
            }
            self.view?.reloadContents()
            
        case .failure(let error):
            print(error)
        }
    }
}
